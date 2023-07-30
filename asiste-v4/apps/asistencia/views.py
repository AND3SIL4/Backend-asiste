from rest_framework.viewsets import ModelViewSet, ReadOnlyModelViewSet
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from apps.users.permission import IsAprendizUser, IsInstructorUser, IsCoordinacionUser, IsBienestarUser
from apps.asistencia.models import Novedad, Aprendiz, Asistencia
from apps.asistencia.serializers import NovedadSerializer, AprendizSerializer, AsistenciaSerializer
from rest_framework.views import Response, status


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
    queryset = Aprendiz.objects.all()
    serializer_class = AprendizSerializer
    permission_classes = [IsAuthenticated, IsAprendizUser]
    authentication_classes = [TokenAuthentication]

    def get_object(self):
        # Función se utiliza para obtener el objeto Aprendiz del usuario autenticado
        return self.request.user.aprendiz

    def perform_update(self, serializer):
        # Aquí se realiza la actualización de los datos del Aprendiz autenticado
        serializer.save()


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


# LISTA DE APRENDICES PARA INSTRUCTOR
class AprendizListView(ReadOnlyModelViewSet):
    queryset = Aprendiz.objects.all()
    serializer_class = AprendizSerializer
    permission_classes = [IsAuthenticated, IsInstructorUser]
    authentication_classes = [TokenAuthentication]

    def get_queryset(self):
        user = self.request.user
        return Aprendiz.objects.filter(ficha_aprendiz__instructor_ficha__user=user)


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
