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


# Permisos
class IsAdminOrReadOnly(permissions.BasePermission):
    def has_permission(self, request, view):
        # Permite todas las operaciones de lectura a cualquier usuario (autenticado o no)
        if request.method in permissions.SAFE_METHODS:
            return True

        # Solo permite operaciones de escritura (POST, PUT, DELETE) a los administradores
        return request.user and request.user.is_staff


class IsOwnerOrReadOnly(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):
        # Permite todas las operaciones de lectura a cualquier usuario (autenticado o no)
        if request.method in permissions.SAFE_METHODS:
            return True

        # Permite operaciones de escritura (PUT, DELETE) solo al propietario del objeto
        return obj.owner == request.user
