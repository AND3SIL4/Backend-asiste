from django.urls import path, include
from rest_framework.routers import DefaultRouter
from apps.asistencia.views import (
    NovedadListView,
    AprendizViewSet,
    AsistenciaViewSet,
    AprendizListView,
    NovedadAprendizView,
    NovedadAcceptanceView
)

router = DefaultRouter()
router.register(r'novedad', NovedadListView, basename='novedades') # Aprendices - Instructores - Coordinacion
router.register(r'aprendiz', AprendizViewSet, basename='aprendiz') # Aprendices
router.register(r'reporte', AsistenciaViewSet, basename='reporte') # Aprendices
router.register(r'aprendices-instructor', AprendizListView, basename='aprendices-instructor') # Instructor
router.register(r'novedad-aprendiz-instructor', NovedadAprendizView, basename='novedad-aprendiz-instructor') # Instructor
router.register(r'novedad-accept', NovedadAcceptanceView, basename='novedad-accept') # BienestarAprendiz - Coordinacion


urlpatterns = [
    path('', include(router.urls)),
]