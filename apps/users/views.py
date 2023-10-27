from rest_framework import generics, authentication, permissions
from apps.users.serializers import UserSerializer, AuthTokenSerializers
from rest_framework.authtoken.views import ObtainAuthToken
from apps.users.permission import IsAprendizUser, IsInstructorUser
from rest_framework.authtoken.models import Token
from rest_framework.response import Response


# * Archivo para logica de negocios de la app de usuarios
# VISTA PARA CREAR UN USUARIO
class CreateUserView(generics.CreateAPIView):
    """Vista para crear un usuario"""
    serializer_class = UserSerializer


# VISTA PARA HACER CRUD EN EL USUARIO
class RetrieveUpdateUserView(generics.RetrieveUpdateAPIView):
    """Vista para GET, PUT, PATCH de usuario"""
    serializer_class = UserSerializer
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]

    def get_object(self):
        return self.request.user

# VISTA PARA CREAR UN TOKEN DE AUTHENTICATION
class CreateTokenView(ObtainAuthToken):
    """Vista para crear un token"""
    serializer_class = AuthTokenSerializers

    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']

        # Obtén el tipo de usuario y agrega al diccionario de respuesta
        user_type = user.user_type
        token, created = Token.objects.get_or_create(user=user)

        return Response({
            'token': token.key,
            'user_type': user_type  # Agrega el tipo de usuario a la respuesta
        })
