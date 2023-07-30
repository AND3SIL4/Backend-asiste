from django.db import models
from apps.users.models import User


# Create your models here.
class Instructor(models.Model):
    class Meta:
        verbose_name = "Instructor"
        verbose_name_plural = "Instructores"

    documento = models.IntegerField(primary_key=True)
    nombres_instructor = models.CharField(max_length=45)
    apellidos_instructor = models.CharField(max_length=45)
    email_institucional = models.CharField(max_length=50)
    user = models.OneToOneField(User, on_delete=models.DO_NOTHING)

    def __str__(self):
        return f"{self.nombres_instructor} {self.apellidos_instructor}"


class Coordinacion(models.Model):
    class Meta:
        verbose_name = "Coordinacion"
        verbose_name_plural = "Coordinaciones"

    id_coordinacion = models.IntegerField(primary_key=True, unique=True)
    nombre_coordinacion = models.CharField(max_length=45, choices=[('TELEINFORMATICA', 'Teleinformática')])

    def __str__(self):
        return self.nombre_coordinacion


class Programa(models.Model):
    class Meta:
        verbose_name = "Programa"
        verbose_name_plural = "Programas"

    id_programa = models.IntegerField(primary_key=True)
    nombre_programa = models.CharField(max_length=45, choices=[('ADSO', 'ADSO')])
    coordinacion_programa = models.ForeignKey(Coordinacion, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.nombre_programa}"


class Horario(models.Model):
    class Meta:
        verbose_name = "Horario"
        verbose_name_plural = "Horarios"

    fecha = models.DateField()
    hora_entrada = models.TimeField()
    hora_salida = models.TimeField()
    salon = models.IntegerField()
    jornada = models.CharField(max_length=10,
                               choices=[('Diurna', 'Diurna'), ('Tarde', 'Tarde'), ('Nocturna', 'Nocturna')])
    asignatura = models.CharField(max_length=45)

    def __str__(self):
        return f"{self.fecha}"


class Ficha(models.Model):
    class Meta:
        verbose_name = "Ficha"
        verbose_name_plural = "Fichas"

    id_ficha = models.IntegerField(primary_key=True)
    horario_ficha = models.ManyToManyField(Horario)
    instructor_ficha = models.ManyToManyField(Instructor)
    nivel_formacion = models.CharField(max_length=20)
    programa_ficha = models.ForeignKey(Programa, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.id_ficha}"


class Aprendiz(models.Model):
    GENERO_CHOICES = (
        ("Masculino", "Masculino"),
        ("Femenino", "Femenino"),
        ("Homosexual", "Homosexual"),
        ("Bisexual", "Bisexual"),
        ("Transexual", "Transexual"),
    )

    documento_aprendiz = models.IntegerField(primary_key=True)
    tipo_documento = models.CharField(max_length=20, choices=[('CC', 'Cedula de ciudadanía'), ('TI', 'Tarjeta de identidad')])
    nombres_aprendiz = models.CharField(max_length=45)
    apellidos_aprendiz = models.CharField(max_length=45)
    email_personal_aprendiz = models.CharField(max_length=45)
    email_institucional_aprendiz = models.CharField(max_length=45)
    numero_celular = models.IntegerField()
    genero_aprendiz = models.CharField(max_length=10, choices=GENERO_CHOICES)
    ficha_aprendiz = models.ForeignKey(Ficha, on_delete=models.CASCADE)
    user = models.OneToOneField(User, on_delete=models.DO_NOTHING)

    class Meta:
        verbose_name = "Aprendiz"
        verbose_name_plural = "Aprendices"
        ordering = ('-nombres_aprendiz',)

    def __str__(self):
        return f"{self.nombres_aprendiz} {self.apellidos_aprendiz}"


class Novedad(models.Model):
    ESTADO_NOVEDAD_CHOICES = (
        (True, 'Aceptada'),
        (False, 'No aceptada'),
    )

    class Meta:
        verbose_name = 'Novedad'
        verbose_name_plural = 'Novedades'

    aprendiz = models.ForeignKey(Aprendiz, on_delete=models.CASCADE)
    id_novedad = models.AutoField(primary_key=True)
    tipo_novedad = models.CharField(max_length=10,
                                    choices=[('Calamidad', 'Calamidad domestica'), ('Medica', 'Novedad medica')])
    observaciones = models.TextField(max_length=30, default='')
    archivo_adjunto = models.FileField(upload_to='pdfs/')
    estado_novedad = models.BooleanField(default=False, choices=ESTADO_NOVEDAD_CHOICES)

    def __str__(self):
        return f'{self.tipo_novedad} {self.id_novedad}'


class Asistencia(models.Model):
    class Meta:
        verbose_name = "Asistencia"
        verbose_name_plural = "Asistencias"

    ESTADO_ASISTENCIA_CHOICES = (
        ('Asiste', 'Asiste'),
        ('Falla', 'Falla'),
        ('Novedad', 'Novedad'),
    )

    aprendiz = models.ForeignKey(Aprendiz, on_delete=models.CASCADE)
    fecha = models.DateField()
    estado_asistencia = models.CharField(max_length=10, choices=ESTADO_ASISTENCIA_CHOICES)
    novedad = models.OneToOneField(Novedad, null=True, blank=True, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.aprendiz} - {self.fecha} - {self.estado_asistencia}"