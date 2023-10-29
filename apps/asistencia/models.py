# Arhivo que controla la interaccion de la arquitectura del backend y la base de datos
from django.db import models
from apps.users.models import User


# Our models here.

## Modelo de coordinacion
class Coordinacion(models.Model):
    class Meta:
        verbose_name = "Coordinacion"
        verbose_name_plural = "Coordinaciones"

    id_coordinacion = models.IntegerField(primary_key=True, unique=True)
    nombre_coordinacion = models.CharField(max_length=45, choices=[('TELEINFORMATICA', 'Teleinformática')])

    def __str__(self):
        return self.nombre_coordinacion


## Modelo de programa
class Programa(models.Model):
    class Meta:
        verbose_name = "Programa"
        verbose_name_plural = "Programas"

    PROGRAMA_CHOICES = (
        ('ADSO', 'Analisis y desarrollo de software'),
        ('ADSI', 'Analisis y desarrollo de sistemas'),
    )

    id_programa = models.IntegerField(primary_key=True)
    nombre_programa = models.CharField(max_length=45, choices=PROGRAMA_CHOICES)
    coordinacion_programa = models.ForeignKey(Coordinacion, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.nombre_programa}"


## modelo de horarios
class HorarioPorDia(models.Model):
    class Meta:
        verbose_name = "Horario"
        verbose_name_plural = "Horarios"

    JORNADA_CHOICES = (
        ('DIURNA', 'Diurna'),
        ('TARDE', 'Tarde'),
        ('NOCTURNA', 'Nocturna')
    )
    DIAS_CHOICES = (
        ('LUNES', 'Lunes'),
        ('MARTES', 'Martes'),
        ('MIERCOLES', 'Miercoles'),
        ('JUEVES', 'Jueves'),
        ('VIERNES', 'Viernes'),
        ('SABADO', 'Sabado'),
        ('DOMINGO', 'Domingo'),
    )

    horario_id = models.IntegerField(primary_key=True, unique=True)
    dia = models.CharField(max_length=45, choices=DIAS_CHOICES)
    hora_entrada = models.TimeField()
    hora_salida = models.TimeField()
    salon = models.IntegerField()
    jornada = models.CharField(max_length=10, choices=JORNADA_CHOICES)
    asignatura = models.CharField(max_length=45)

    def __str__(self):
        return f"{self.dia} - {self.jornada} - {self.salon} - {self.asignatura}"


## Modelo de fichas
class Ficha(models.Model):
    class Meta:
        verbose_name = "Ficha"
        verbose_name_plural = "Fichas"
    NIVEL_FORMACION_CHOICES = (
        ('TECNICO', 'Técnico'),
        ('TECNOLOGO', 'Tecnologo'),
        ('COMPLEMENTARIO', 'Complementario'),
    )
    id_ficha = models.IntegerField(primary_key=True)
    horario_ficha = models.ManyToManyField(HorarioPorDia)
    # instructores = models.ManyToManyField(Instructor)
    nivel_formacion = models.CharField(max_length=20, choices=NIVEL_FORMACION_CHOICES)
    programa_ficha = models.ForeignKey(Programa, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.id_ficha}"


## Modelo de instructor
class Instructor(models.Model):
    class Meta:
        verbose_name = "Instructor"
        verbose_name_plural = "Instructores"

    documento = models.IntegerField(primary_key=True)
    nombres_instructor = models.CharField(max_length=45)
    apellidos_instructor = models.CharField(max_length=45)
    email_institucional = models.CharField(max_length=50)
    fichas = models.ManyToManyField(Ficha)
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='instructor')
    registro_asistencia = models.ManyToManyField('Asistencia', blank=True)


    def __str__(self):
        return f"{self.nombres_instructor} {self.apellidos_instructor}"


## Modelo de aprendices
class Aprendiz(models.Model):
    GENERO_CHOICES = (
        ("Masculino", "Masculino"),
        ("Femenino", "Femenino"),
        ("Homosexual", "Homosexual"),
        ("Bisexual", "Bisexual"),
        ("Transexual", "Transexual"),
    )
    TIPO_DOCUMENTO_CHOICES = (
        ('CC', 'Cedula de ciudadanía'),
        ('TI', 'Tarjeta de identidad'),
        ('PEP', 'PEP')
    )

    documento_aprendiz = models.IntegerField(primary_key=True)
    tipo_documento = models.CharField(max_length=20, choices=TIPO_DOCUMENTO_CHOICES)
    nombres_aprendiz = models.CharField(max_length=45)
    apellidos_aprendiz = models.CharField(max_length=45)
    email_personal_aprendiz = models.CharField(max_length=45)
    email_institucional_aprendiz = models.CharField(max_length=45)
    numero_celular = models.BigIntegerField()
    genero_aprendiz = models.CharField(max_length=10, choices=GENERO_CHOICES)
    ficha_aprendiz = models.ForeignKey(Ficha, on_delete=models.CASCADE)
    user = models.OneToOneField(User, related_name='aprendiz', on_delete=models.DO_NOTHING)

    class Meta:
        verbose_name = "Aprendiz"
        verbose_name_plural = "Aprendices"
        ordering = ('-nombres_aprendiz',)

    def __str__(self):
        return f"{self.nombres_aprendiz} {self.apellidos_aprendiz}"


## Modelo de asistencias
class Asistencia(models.Model):
    class Meta:
        verbose_name = "Asistencia"
        verbose_name_plural = "Asistencias"

    ESTADO_ASISTENCIA_CHOICES = (
        ('Asiste', 'Asiste'),
        ('Falla', 'Falla'),
        ('Novedad', 'Novedad'),
    )
    # horario = models.ManyToManyField(Horario, blank=False, null=False)
    fecha_asistencia = models.DateField(auto_now_add=True)
    aprendiz = models.ForeignKey(Aprendiz, on_delete=models.CASCADE, blank=False, null=False)
    presente = models.CharField(max_length=45, choices=ESTADO_ASISTENCIA_CHOICES,default=False, blank=False, null=False)

    def __str__(self):
        return f"{self.fecha_asistencia} - {self.aprendiz.nombres_aprendiz}"


## Modelo de novedades
class Novedad(models.Model):
    ESTADO_NOVEDAD_CHOICES = (
        (True, 'Aceptada'),
        (False, 'No aceptada'),
    )

    class Meta:
        verbose_name = 'Novedad'
        verbose_name_plural = 'Novedades'

    aprendiz = models.ForeignKey(Aprendiz, on_delete=models.CASCADE, blank=False, null=False)
    id_novedad = models.AutoField(primary_key=True)
    asistencia = models.ForeignKey(Asistencia, on_delete=models.CASCADE)
    tipo_novedad = models.CharField(max_length=10, choices=[('Calamidad', 'Calamidad domestica'), ('Medica', 'Novedad medica')])
    observaciones = models.TextField(max_length=30)
    archivo_adjunto = models.FileField(upload_to='pdfs/')
    estado_novedad = models.BooleanField(default=False, choices=ESTADO_NOVEDAD_CHOICES)

    def __str__(self):
        return f'{self.tipo_novedad} {self.id_novedad}'
