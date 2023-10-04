from django.contrib import admin
from django.urls import path, include
from drf_spectacular.views import (
    SpectacularAPIView,
    SpectacularSwaggerView,
    SpectacularRedocView
)

urlpatterns = [
    path('admin/', admin.site.urls),
    path('users/', include('apps.users.urls')),
    path('asistencia/', include('apps.asistencia.urls')),
    
    ## Desacargar documentacion de la API en formato .yaml
    path('api/schema/', SpectacularAPIView.as_view(), name='schema'),

    ## Cargar documentacion de la API visualmente y en el navegador
    path('api/schema/swagger-ui/', SpectacularSwaggerView.as_view(url_name='schema'), name='swagger-ui'),
    
    ## Prueba de endpoints y respuestas en formato JSON con key: value
    path('api/schema/redoc/', SpectacularRedocView.as_view(url_name='schema'), name='redoc'),
]
