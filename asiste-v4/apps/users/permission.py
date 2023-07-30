from rest_framework import permissions


# Permisos para usuario aprendiz
class IsAprendizUser(permissions.BasePermission):
    def has_permission(self, request, view):
        return request.user.user_type == 'APRENDIZ'


class IsAprendizUserReadOnly(permissions.BasePermission):
    def has_permission(self, request, view):
        # Permite métodos de lectura (GET, HEAD, OPTIONS)
        if request.method in permissions.SAFE_METHODS:
            return request.user.user_type == 'APRENDIZ'
        # Permite a todos los usuarios autenticados realizar otras operaciones
        return True
