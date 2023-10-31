## Archivo encargado de serizar los datos para facil lectura desde el front

from rest_framework import serializers
from apps.asistencia.models import (
    Instructor,
    Coordinacion,
    Programa,
    HorarioPorDia,
    Ficha,
    Aprendiz,
    Novedad,
    Asistencia,
)



## Serializador datos coordinacion
class CoordinacionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Coordinacion
        fields = '__all__'


## Serializador datos programa
class ProgramaSerializer(serializers.ModelSerializer):
    coordinacion_programa = CoordinacionSerializer()

    class Meta:
        model = Programa
        fields = '__all__'


## Serializador datos horarios
class HorarioSerializer(serializers.ModelSerializer):
    class Meta:
        model = HorarioPorDia
        fields = '__all__'


## Serializador datos fichas
class FichaSerializer(serializers.ModelSerializer):
    horario_ficha = HorarioSerializer(many=True)
    # instructores = InstructorSerializer(many=True)
    programa_ficha = ProgramaSerializer()

    class Meta:
        model = Ficha
        fields = '__all__'



## Serializador datos instructor
class InstructorSerializer(serializers.ModelSerializer):
    user_details = serializers.SerializerMethodField()
    fichas = FichaSerializer(many=True)

    class Meta:
        model = Instructor
        fields = '__all__'

    # Método para obtener los detalles del usuario relacionado
    def get_user_details(self, instructor):
        user = instructor.user
        return {
            'document': user.document,
            'username': user.username,
            'email': user.email,
            'user_type': user.user_type
        }



## Serializador datos aprendices
class AprendizSerializer(serializers.ModelSerializer):
    user_details = serializers.SerializerMethodField()
    ficha_details = serializers.SerializerMethodField()

    class Meta:
        model = Aprendiz
        fields = '__all__'

    # Método para obtener los detalles del usuario relacionado
    def get_user_details(self, aprendiz):
        user = aprendiz.user
        return {
            'document': user.document,
            'username': user.username,
            'email': user.email,
            'user_type': user.user_type
        }

    # Método para obtener los detalles de la ficha asociada
    def get_ficha_details(self, aprendiz):
        ficha = aprendiz.ficha_aprendiz
        return FichaSerializer(ficha).data


## Serializador datos novedades
class NovedadSerializer(serializers.ModelSerializer):
    # Campos de solo lectura para mostrar los detalles del usuario y la ficha
    user = serializers.ReadOnlyField(source='aprendiz.user.username')
    ficha = serializers.ReadOnlyField(source='aprendiz.ficha_aprendiz.id_ficha')
    nombre = serializers.ReadOnlyField(source='aprendiz.nombres_aprendiz')
    apellidos = serializers.ReadOnlyField(source='aprendiz.apellidos_aprendiz')
    documento = serializers.ReadOnlyField(source='aprendiz.documento_aprendiz')

    class Meta:
        model = Novedad
        fields = '__all__'


## Serializador datos asistencias
class AsistenciaSerializer(serializers.ModelSerializer):
    # fecha_asistencia = serializers.DateField()
    nombres_aprendiz = serializers.ReadOnlyField(source='aprendiz.nombres_aprendiz')
    apellidos_aprendiz = serializers.ReadOnlyField(source='aprendiz.apellidos_aprendiz')

    class Meta:
        model = Asistencia
        fields = ['id', 'fecha_asistencia', 'nombres_aprendiz', 'apellidos_aprendiz', 'aprendiz', 'presente']
        read_only_fields = ['fecha_asistencia']