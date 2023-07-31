from rest_framework.viewsets import ModelViewSet, ReadOnlyModelViewSet
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from apps.users.permission import IsAprendizUser, IsInstructorUser, IsCoordinacionUser, IsBienestarUser
from apps.asistencia.models import Novedad, Aprendiz, Asistencia, Instructor, Horario
from apps.asistencia.serializers import NovedadSerializer, AprendizSerializer, AsistenciaSerializer, InstructorSerializer
from rest_framework.views import Response, status
from rest_framework.decorators import action


# Create your views here.

# PERMISOS PARA USUARIOS
class NovedadListView(ModelViewSet):
    queryset = Novedad.objects.all()
    serializer_class = NovedadSerializer
    permission_classes = [IsAuthenticated]
    authentication_classes = [TokenAuthentication]

    def get_queryset(self):
        user = self.request.user

        # Aprendiz: puede ver sus propias novedades y datos de asistencia
        if IsAprendizUser().has_permission(self.request, self):
            return self.queryset.filter(aprendiz__user=user.document)

        # Instructor: puede ver novedades y actualizar datos de asistencia de sus aprendices
        if IsInstructorUser().has_permission(self.request, self):
            return self.queryset.filter(aprendiz__ficha_aprendiz__instructor_ficha__user=user)

        # Coordinación y Bienestar: pueden editar novedades
        if IsBienestarUser().has_permission(self.request, self):
            return self.queryset
        if IsCoordinacionUser().has_permission(self.request, self):
            return self.queryset

        # Si no es ninguno de los roles anteriores, no se permite el acceso
        return Novedad.objects.none()

    def perform_create(self, serializer):
        user = self.request.user

        # Aprendiz: vincula la novedad con su perfil
        if IsAprendizUser().has_permission(self.request, self):
            serializer.save(aprendiz__user=user)
        else:
            # Instructor, Coordinación y Bienestar, permiten vincular la novedad con cualquier aprendiz
            serializer.save()


# ACTUALIZAR DATOS DE APRENDIZ
class AprendizViewSet(ModelViewSet):
    serializer_class = AprendizSerializer
    permission_classes = [IsAuthenticated, IsAprendizUser]
    authentication_classes = [TokenAuthentication]

    def get_queryset(self):
        return Aprendiz.objects.filter(user=self.request.user)

    def perform_update(self, serializer):
        serializer.save()

    def patch(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = self.get_serializer(instance, data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data)


# CREAR NOVEDADES Y ESTADO DE ASISTENCIA DE APRENDICES
class AsistenciaViewSet(ReadOnlyModelViewSet):
    queryset = Asistencia.objects.all()
    serializer_class = AsistenciaSerializer
    permission_classes = [IsAuthenticated, IsAprendizUser]
    authentication_classes = [TokenAuthentication]

    def get_queryset(self):
        user = self.request.user

        try:
            # Intenta obtener el objeto Aprendiz a través de la clave foránea 'user'
            aprendiz = Aprendiz.objects.get(user=user)
            return self.queryset.filter(aprendiz=aprendiz)
        except Aprendiz.DoesNotExist:
            # Si el objeto Aprendiz no existe para el usuario, devuelve una consulta vacía
            return Asistencia.objects.none()


# NOVEDADES APRENDICES PARA INSTRUCTORES
class NovedadAprendizView(ReadOnlyModelViewSet):
    queryset = Novedad.objects.all()
    serializer_class = NovedadSerializer
    permission_classes = [IsAuthenticated, IsInstructorUser]
    authentication_classes = [TokenAuthentication]

    def get_queryset(self):
        user = self.request.user
        return Novedad.objects.filter(aprendiz__ficha_aprendiz__instructor_ficha__user=user)


# MODIFICAR NOVEDADES PARA SU ACEPTACIÓN
class NovedadAcceptanceView(ModelViewSet):
    queryset = Novedad.objects.all()
    serializer_class = NovedadSerializer
    permission_classes = [IsAuthenticated, IsCoordinacionUser | IsBienestarUser]
    authentication_classes = [TokenAuthentication]

    def get_permissions(self):
        # Asignar el permiso adecuado según el tipo de usuario
        if self.request.user.user_type == 'COORDINACION':
            return [IsCoordinacionUser()]
        elif self.request.user.user_type == 'BIENESTAR':
            return [IsBienestarUser()]
        else:
            return []

    def update(self, request, *args, **kwargs):
        # Solo permitir actualización si el usuario es Coordinación o Bienestar
        if not (request.user.user_type == 'COORDINACION' or request.user.user_type == 'BIENESTAR'):
            return Response({'error': 'No tienes permiso para realizar esta acción.'}, status=status.HTTP_403_FORBIDDEN)

        # Procesar la actualización como de costumbre
        return super().update(request, *args, **kwargs)


# LISTA DE APRENDICES Y LLAMADO DE ASISTENCIA, POR INSTRUCTOR
class InstructorViewSet(ModelViewSet):
    queryset = Instructor.objects.all()
    serializer_class = InstructorSerializer
    permission_classes = [IsAuthenticated, IsInstructorUser]
    authentication_classes = [TokenAuthentication]

    @action(detail=True, methods=['get'])
    def lista_asistencia(self, request, pk=None):
        instructor = self.get_object()
        ficha = instructor.instructor_ficha.first()

        if not ficha:
            return Response({'error': 'El instructor no tiene una ficha asociada.'}, status=status.HTTP_404_NOT_FOUND)

        lista_asistencia = []

        for instructor in ficha.instructor_ficha.all():
            for horario in instructor.horarios.all():
                for aprendiz in ficha.aprendiz_set.all():
                    registro_asistencia, created = Asistencia.objects.get_or_create(
                        horario=horario,
                        aprendiz=aprendiz,
                        fecha_asistencia=horario.fecha
                    )
                    lista_asistencia.append({
                        'horario': horario.id,
                        'aprendiz': aprendiz.documento_aprendiz,
                        'presente': registro_asistencia.presente,
                    })

        return Response(lista_asistencia)

    @action(detail=True, methods=['post'])
    def registrar_asistencia(self, request, pk=None):
        instructor = self.get_object()
        horario_id = request.data.get('horario_id')
        aprendices_documentos = request.data.get('aprendices_documentos', [])

        if not horario_id or not aprendices_documentos:
            return Response({'error': 'Debe proporcionar el ID del horario y la lista de documentos de aprendices.'},
                            status=status.HTTP_400_BAD_REQUEST)

        try:
            horario = Horario.objects.get(pk=horario_id)
        except Horario.DoesNotExist:
            return Response({'error': 'El horario especificado no existe.'}, status=status.HTTP_404_NOT_FOUND)

        for documento in aprendices_documentos:
            try:
                aprendiz = Aprendiz.objects.get(documento_aprendiz=documento)
            except Aprendiz.DoesNotExist:
                return Response({'error': f'El aprendiz con el documento {documento} no existe.'},
                                status=status.HTTP_404_NOT_FOUND)

            registro_asistencia, created = Asistencia.objects.get_or_create(
                horario=horario,
                aprendiz=aprendiz,
                fecha_asistencia=horario.fecha
            )
            registro_asistencia.presente = True
            registro_asistencia.save()

        return Response({'detail': 'Asistencia registrada correctamente.'}, status=status.HTTP_200_OK)

