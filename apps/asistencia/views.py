from rest_framework.viewsets import ModelViewSet, ReadOnlyModelViewSet
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from apps.users.permission import IsAprendizUser, IsInstructorUser
from apps.asistencia.models import (
    Novedad,
    Aprendiz,
    Asistencia,
    Instructor,
    HorarioPorDia,
    Ficha,
)
from apps.asistencia.serializers import (
    NovedadSerializer,
    AprendizSerializer,
    AsistenciaSerializer,
    InstructorSerializer,
)
from rest_framework.views import Response, status
from django.db.models import Q
from rest_framework.decorators import action


# ARCHIVO CON LA LOGICA DE NEGOCIOS PARA LA APP DE REGISTRO DE ASISTENCIA
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
            return self.queryset.filter(
                Q(aprendiz__ficha_aprendiz__instructores__user=user)
                | Q(aprendiz__ficha_aprendiz__instructores__user__instructor__user=user)
            )

        # instructores pueden editar novedades
        if IsInstructorUser().has_permission(self.request, self):
            return self.queryset

        # Si no es ninguno de los roles anteriores, no se permite el acceso
        return Novedad.objects.none()

    def perform_create(self, serializer):
        user = self.request.user

        # Aprendiz: vincula la novedad con su perfil
        if IsAprendizUser().has_permission(self.request, self):
            serializer.save(aprendiz__user=user)
        else:
            # Instructor, permiten vincular la novedad con cualquier aprendiz
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
        return Novedad.objects.filter(
            aprendiz__ficha_aprendiz__instructor_ficha__user=user
        )


# MODIFICAR NOVEDADES PARA SU ACEPTACIÓN
class NovedadAcceptanceView(ModelViewSet):
    queryset = Novedad.objects.all()
    serializer_class = NovedadSerializer
    permission_classes = [IsAuthenticated, IsInstructorUser]
    authentication_classes = [TokenAuthentication]

    def get_permissions(self):
        # Asignar el permiso adecuado según el tipo de usuario
        if self.request.user.is_authenticated:
            if self.request.user.user_type == "INSTRUCTOR":
                return [IsInstructorUser()]
            else:
                return []
        else:
            return []

    def update(self, request, *args, **kwargs):
        # Solo permitir actualización si el usuario es INSTRUCTOR
        if not (request.user.user_type == "INSTRUCTOR"):
            return Response(
                {"error": "No tienes permiso para realizar esta acción."},
                status=status.HTTP_403_FORBIDDEN,
            )

        # Procesar la actualización como de costumbre
        return super().update(request, *args, **kwargs)


# LISTA DE APRENDICES Y LLAMADO DE ASISTENCIA, POR INSTRUCTOR
class InstructorViewSet(ModelViewSet):
    serializer_class = InstructorSerializer
    permission_classes = [IsAuthenticated, IsInstructorUser]
    authentication_classes = [TokenAuthentication]

    @action(detail=True, methods=["PATCH"])
    def get_queryset(self):
        # Obtener el instructor asociado al usuario que ha iniciado sesión
        instructor = self.request.user.instructor

        # Devolver solo el instructor asociado al usuario actual
        return Instructor.objects.filter(documento=instructor.documento)

    @action(detail=True, methods=["PATCH"])
    def update_instructor(self, request, pk=None):
        # Obtener el instructor asociado al usuario que ha iniciado sesión
        instructor = self.request.user.instructor

        # Obtener el objeto del instructor asociado al usuario
        instance = Instructor.objects.get(documento=instructor.documento)

        # Obtener los datos enviados en el request
        data = request.data

        # Actualizar el objeto del instructor con los nuevos datos del request
        serializer = InstructorSerializer(instance, data=data, partial=True)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    @action(detail=True, methods=["GET"])
    def lista_aprendices(self, request, pk=None):
        instructor = self.get_object()
        aprendices = Aprendiz.objects.filter(ficha_aprendiz__instructores=instructor)
        serializer = AprendizSerializer(aprendices, many=True)
        return Response(serializer.data)

    def retrieve(self, request, *args, **kwargs):
        return super().retrieve(request, *args, **kwargs)

    @action(detail=True, methods=["POST", "GET"])
    def registrar_asistencia(self, request, pk=None):
        instructor = self.get_object()
        data = request.data

        # Asegurarse de que el usuario actual sea un Instructor y esté relacionado con este Instructor específico
        if not (
            request.user.user_type == "INSTRUCTOR" and instructor.user == request.user
        ):
            return Response(
                {
                    "error": "No tienes permiso para registrar asistencia para este instructor."
                },
                status=status.HTTP_403_FORBIDDEN,
            )

        # Obtener la ficha y el horario asociado a la asistencia
        id_ficha = data.get("ficha_id")
        horario_id = data.get("horario_id")
        documento_aprendiz = data.get("documento_aprendiz")
        nombres_aprendiz = data.get("nombres_aprendiz")
        apellidos_aprendiz = data.get("apellidos_aprendiz")

        try:
            ficha = Ficha.objects.get(id_ficha=id_ficha)
        except Ficha.DoesNotExist:
            return Response(
                {"error": "Ficha no encontrada"}, status=status.HTTP_404_NOT_FOUND
            )

        try:
            HorarioPorDia = HorarioPorDia.objects.get(horario_id=horario_id)
        except HorarioPorDia.DoesNotExist:
            return Response(
                {"error": "Horario no existe"}, status=status.HTTP_404_NOT_FOUND
            )

        # Verificar si el aprendiz asociado a la asistencia pertenece a la ficha de este instructor
        try:
            aprendiz_data = data.get("aprendiz", {})
            if not isinstance(aprendiz_data, dict):
                return Response(
                    {
                        "error": "Datos del aprendiz no proporcionados o en un formato incorrecto."
                    },
                    status=status.HTTP_400_BAD_REQUEST,
                )

            documento_aprendiz = aprendiz_data.get("documento_aprendiz")
            if documento_aprendiz is None:
                return Response(
                    {"error": "Documento del aprendiz no proporcionado."},
                    status=status.HTTP_400_BAD_REQUEST,
                )

            aprendiz = Aprendiz.objects.get(
                documento_aprendiz=documento_aprendiz, ficha_aprendiz=ficha
            )
        except Aprendiz.DoesNotExist:
            return Response(
                {"error": "Aprendiz no existe."}, status=status.HTTP_404_NOT_FOUND
            )

        # Crear la asistencia
        asistencia_data = {
            "aprendiz": aprendiz.pk,
            "fecha_asistencia": data.get("fecha_asistencia"),
            "presente": data.get("presente"),
        }

        asistencia_serializer = AsistenciaSerializer(data=asistencia_data)

        if asistencia_serializer.is_valid():
            asistencia_serializer.save()
            return Response(asistencia_serializer.data, status=status.HTTP_201_CREATED)

        return Response(
            asistencia_serializer.errors, status=status.HTTP_400_BAD_REQUEST
        )
