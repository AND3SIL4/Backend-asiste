## Archivo encargado de la comunicacion entre la base de datos y el backend
### Encargado de la estructura del usuario

from django.db import models
from django.contrib.auth.models import (
    AbstractUser,
    PermissionsMixin,
    BaseUserManager,
)


# * Models here.


# Superuser model
class UserManager(BaseUserManager):
    def create_user(self, document, password, email, user_type, **extra_fields):
        if not document:
            raise ValueError('Falta documento...')
        if not email:
            raise ValueError('Falta email...')

        email = self.normalize_email(email)
        user = self.model(document=document, email=email, user_type=user_type, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)

        return user

    def create_superuser(self, document, password, email, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        extra_fields.setdefault('username', 'ADMINISTRADOR')
        extra_fields.setdefault('first_name', 'ASISTENTE')
        extra_fields.setdefault('last_name', 'COORDINACION')



        return self.create_user(document, password, email, user_type='SUPERUSER', **extra_fields)


# Normal user model
class User(AbstractUser, PermissionsMixin):
    USER_TYPE_CHOICES = (
        ('APRENDIZ', 'Aprendiz'),
        ('INSTRUCTOR', 'Instructor'),
        ('COORDINACION', 'Coordinacion'),
        ('BIENESTAR', 'Bienestar'),
    )
    document = models.BigIntegerField(primary_key=True, unique=True)
    username = models.CharField(max_length=45)
    email = models.EmailField(max_length=100, unique=True)
    user_type = models.CharField(max_length=45, choices=USER_TYPE_CHOICES)
    is_staff = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)

    objects = UserManager()

    USERNAME_FIELD = 'document'

    def __str__(self):
        return f'{self.first_name} {self.last_name} - {self.username} - {self.user_type}'
