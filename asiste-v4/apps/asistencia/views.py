from rest_framework.viewsets import ModelViewSet, ReadOnlyModelViewSet
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from apps.users.permission import IsAprendizUser, IsOwnerOrReadOnly
from apps.asistencia.models import Novedad
from apps.asistencia.serializers import NovedadSerializer


# Create your views here.
class NovedadListView(ModelViewSet):
    queryset = Novedad.objects.all()
    serializer_class = NovedadSerializer
    permission_classes = [IsAuthenticated]
    authentication_classes = [TokenAuthentication]

    # Filtrar información por usuario autenticado
    def get_queryset(self):
        user = self.request.user
        return self.queryset.filter(aprendiz__user=user)

    # Creacion de información ligada al usuario padre
    def perform_create(self, serializer):
        user = self.request.user
        serializer.save(user=user)
