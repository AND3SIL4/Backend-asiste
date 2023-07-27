from django.shortcuts import render
from rest_framework import generics, authentication, permissions
from rest_framework.authtoken.views import ObtainAuthToken

from app.users.serializers import UserSerializers, AuthTokenSerializer
from app.users.models import User

# Crear tus vistas aquí.
# Vista para crear un usuario.
class CreateUserView(generics.CreateAPIView):
    serializer_class = UserSerializers

# Vista para obtener y actualizar la información de un usuario.
class RetrieveUpdateUserView(generics.RetrieveUpdateAPIView):
    serializer_class = UserSerializers
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]

    def get_object(self):
        return self.request.user

# Vista para crear un token de autenticación.
class CreateTokenView(ObtainAuthToken):
    serializer_class = AuthTokenSerializer

