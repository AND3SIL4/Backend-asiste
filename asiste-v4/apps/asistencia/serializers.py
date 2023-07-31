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
    # Campos de solo lectura para mostrar los detalles del usuario y la ficha
    user = serializers.ReadOnlyField(source='aprendiz.user.username')
    ficha = serializers.ReadOnlyField(source='aprendiz.ficha_aprendiz.id_ficha')
    nombre = serializers.ReadOnlyField(source='aprendiz.nombres_aprendiz')
    apellidos = serializers.ReadOnlyField(source='aprendiz.apellidos_aprendiz')
    documento = serializers.ReadOnlyField(source='aprendiz.documento_aprendiz')

    class Meta:
        model = Novedad
        fields = '__all__'


class AsistenciaSerializer(serializers.ModelSerializer):
    horario_id = serializers.IntegerField(source='horario.id', read_only=True)
    aprendiz_documento = serializers.IntegerField(source='aprendiz.documento_aprendiz', read_only=True)
    horario_fecha = serializers.DateField(source='horario.fecha', read_only=True)
    horario_hora_entrada = serializers.TimeField(source='horario.hora_entrada', read_only=True)
    horario_hora_salida = serializers.TimeField(source='horario.hora_salida', read_only=True)
    salon = serializers.IntegerField(source='horario.salon', read_only=True)
    jornada = serializers.CharField(source='horario.jornada', read_only=True)
    asignatura = serializers.CharField(source='horario.asignatura', read_only=True)
    nombres_aprendiz = serializers.CharField(source='aprendiz.nombres_aprendiz', read_only=True)
    apellidos_aprendiz = serializers.CharField(source='aprendiz.apellidos_aprendiz', read_only=True)

    class Meta:
        model = Asistencia
        fields = ['horario_id', 'aprendiz_documento', 'horario_fecha', 'horario_hora_entrada', 'horario_hora_salida',
                  'salon', 'jornada', 'asignatura', 'nombres_aprendiz', 'apellidos_aprendiz', 'presente']