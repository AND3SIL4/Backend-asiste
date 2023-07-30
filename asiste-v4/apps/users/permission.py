from rest_framework import permissions


class IsUserType(permissions.BasePermission):
    def __init__(self, allowed_types):
        self.allowed_types = allowed_types

    def has_permission(self, request, view):
        return request.user.user_type in self.allowed_types


class IsAprendizUser(IsUserType):
    def __init__(self):
        super().__init__(allowed_types=['APRENDIZ'])


class IsInstructorUser(IsUserType):
    def __init__(self):
        super().__init__(allowed_types=['INSTRUCTOR'])


class IsCoordinacionUser(IsUserType):
    def __init__(self):
        super().__init__(allowed_types=['COORDINACION'])


class IsBienestarUser(IsUserType):
    def __init__(self):
        super().__init__(allowed_types=['BIENESTAR'])
