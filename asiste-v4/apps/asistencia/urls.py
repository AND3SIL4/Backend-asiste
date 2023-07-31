from django.urls import path, include
from rest_framework.routers import DefaultRouter
from apps.asistencia.views import (
    NovedadListView,
    AprendizViewSet,
    AsistenciaViewSet,
    NovedadAprendizView,
    NovedadAcceptanceView,
    InstructorViewSet,
    lista_aprendices_instructor,
    lista_asistencia,
)

# Crear un enrutador para las vistas basadas en ViewSets
router = DefaultRouter()
# Usuarios autenticados de cualquier tipo (Aprendiz, Instructor, Coordinación o Bienestar).
# Los aprendices solo verán sus propias novedades y datos de asistencia.
# Los instructores podrán ver novedades y actualizar datos de asistencia de sus aprendices.
# Coordinación y Bienestar podrán editar novedades.
router.register(r'novedades', NovedadListView, basename='novedades')
# Usuarios autenticados con el tipo de usuario "Aprendiz" podrán acceder y actualizar sus propios datos.
router.register(r'aprendices', AprendizViewSet, basename='aprendices')
# Usuarios autenticados con el tipo de usuario "Aprendiz" podrán acceder a sus propias asistencias.
router.register(r'asistencias', AsistenciaViewSet, basename='asistencias')
# Usuarios autenticados con el tipo de usuario "Instructor" podrán acceder a las novedades de sus aprendices.
router.register(r'novedades-aprendices', NovedadAprendizView, basename='novedades-aprendices')
# Usuarios autenticados con el tipo de usuario "Coordinación" o "Bienestar" podrán acceder y actualizar novedades para su aceptación.
router.register(r'novedades-acceptation', NovedadAcceptanceView, basename='novedades-acceptation')
# Usuarios autenticados con el tipo de usuario "Instructor" podrán acceder a la información de los instructores y usar las acciones lista_asistencia y registrar_asistencia.
router.register(r'instructor', InstructorViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('instructores/<int:instructor_id>/lista_aprendices/', lista_aprendices_instructor, name='lista_aprendices_instructor'),
    path('instructores/<int:instructor_id>/lista_asistencia/', lista_asistencia, name='lista_asistencia'),
]
