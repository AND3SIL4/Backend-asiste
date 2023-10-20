## Archivo que se encarga de los permisos segun roles de usuarios
from rest_framework import permissions


# Dependiendo del tipo de usuario
class IsUserType(permissions.BasePermission):
    def __init__(self, allowed_types):
        self.allowed_types = allowed_types

    def has_permission(self, request, view):
        return request.user.user_type in self.allowed_types


# Dependiendo si es aprendiz
class IsAprendizUser(IsUserType):
    def __init__(self):
        super().__init__(allowed_types=['APRENDIZ'])


# Dependiendo si es instructor
class IsInstructorUser(IsUserType):
    def __init__(self):
        super().__init__(allowed_types=['INSTRUCTOR'])

