from rest_framework import serializers
from apps.asistencia.models import (
    Instructor,
    Coordinacion,
    Programa,
    Horario,
    Ficha,
    Aprendiz,
    Novedad,
    Asistencia,
)


class InstructorSerializer(serializers.ModelSerializer):
    user_details = serializers.SerializerMethodField()

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


class CoordinacionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Coordinacion
        fields = '__all__'


class AsistenciaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Asistencia
        fields = '__all__'


class ProgramaSerializer(serializers.ModelSerializer):
    coordinacion_programa = CoordinacionSerializer()

    class Meta:
        model = Programa
        fields = '__all__'


class HorarioSerializer(serializers.ModelSerializer):
    class Meta:
        model = Horario
        fields = '__all__'


class FichaSerializer(serializers.ModelSerializer):
    horario_ficha = HorarioSerializer(many=True)
    instructor_ficha = InstructorSerializer(many=True)
    programa_ficha = ProgramaSerializer()

    class Meta:
        model = Ficha
        fields = '__all__'


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


class NovedadSerializer(serializers.ModelSerializer):
    aprendiz = AprendizSerializer()

    class Meta:
        model = Novedad
        fields = '__all__'
