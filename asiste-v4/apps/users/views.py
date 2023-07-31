from django.shortcuts import render
from rest_framework import generics, authentication, permissions
from apps.users.serializers import UserSerializer, AuthTokenSerializers
from rest_framework.authtoken.views import ObtainAuthToken
from apps.users.models import User
from apps.users.permission import IsAprendizUser


# Create your views here.
# VISTA PARA CREAR UN USUARIO
class CreateUserView(generics.CreateAPIView):
    """Vista para crear un usuario"""
    serializer_class = UserSerializer


# VISTA PARA HACER CRUD EN EL USUARIO
class RetrieveUpdateUserView(generics.RetrieveUpdateAPIView):
    """Vista para GET, PUT, PATCH de usuario"""
    serializer_class = UserSerializer
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated, IsAprendizUser]

    def get_object(self):
        return self.request.user


# VISTA PARA CREAR UN TOKEN DE AUTHENTICATION
class CreateTokenView(ObtainAuthToken):
    """Vista para crear un token"""
    serializer_class = AuthTokenSerializers
