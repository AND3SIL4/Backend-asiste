from django.urls import path, include
from rest_framework.routers import DefaultRouter
from apps.asistencia.views import NovedadListView

router = DefaultRouter()
router.register(r'novedad', NovedadListView, basename='aprendices')

urlpatterns = [
    path('', include(router.urls))
]