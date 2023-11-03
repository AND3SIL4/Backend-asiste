from django.urls import path, include
from rest_framework.routers import DefaultRouter
from apps.asistencia.views import (
    NovedadListView,
    AprendizViewSet,
    AsistenciaViewSet,
    NovedadAprendizView,
    NovedadAcceptanceView,
    InstructorViewSet,
    VerAsistenciasInstructorViewSet,
    UpdateAsistenciaView,
)

# Crear un enrutador para las vistas basadas en ViewSets
router = DefaultRouter()
# Usuarios autenticados de cualquier tipo (Aprendiz, Instructor, Coordinación o Bienestar).
# Los aprendices solo verán sus propias novedades y datos de asistencia.
# Los instructores podrán ver novedades y actualizar datos de asistencia de sus aprendices.
# Coordinación y Bienestar podrán editar novedades.
router.register(r"novedades", NovedadListView, basename="novedades")
# Usuarios autenticados con el tipo de usuario "Aprendiz" podrán acceder y actualizar sus propios datos.
router.register(r"aprendices", AprendizViewSet, basename="aprendices")
# Usuarios autenticados con el tipo de usuario "Aprendiz" podrán acceder a sus propias asistencias.
router.register(r"asistencias", AsistenciaViewSet, basename="asistencias")
# Usuarios autenticados con el tipo de usuario "Instructor" podrán acceder a las novedades de sus aprendices.
router.register(
    r"novedades-aprendices", NovedadAprendizView, basename="novedades-aprendices"
)
# Usuarios autenticados con el tipo de usuario "Coordinación" o "Bienestar" podrán acceder y actualizar novedades para su aceptación.
router.register(
    r"novedades-acceptation", NovedadAcceptanceView, basename="novedades-acceptation"
)
# Usuarios Instructores pueden ver sus datos y actualizarlos
router.register(r"instructores", InstructorViewSet, basename="instructores")
# # Usuarios Instructores pueden ver sus datos y actualizarlos

# vista para obtener las asistencias de los aprendices
router.register(
    r"ver_asistencias/(?P<instructor_id>\d+)",
    VerAsistenciasInstructorViewSet,
    basename="ver-asistencias",
)

# vista para actualizar la asistencia
# router.register(r'actualizar_asistencia/<int:pk>/', UpdateAsistenciaView, basename='actualizar-asistencia')


urlpatterns = [
    path("", include(router.urls)),
    path(
        "actualizar_asistencia/<int:pk>/",
        UpdateAsistenciaView.as_view(),
        name="actualizar-asistencia",
    ),
]

urlpatterns += router.urls
