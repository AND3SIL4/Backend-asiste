from django.db import models
from django.contrib.auth.models import (
    AbstractBaseUser, 
    PermissionsMixin,
    BaseUserManager,
)

# Create your models here.
# Creacion de perfil de usuario admin
class UserProfileManager(BaseUserManager):
    """ Manager for user profiles"""
    def create_user(self, document, password, **extra_fields):
        if not document:
            raise ValueError('The dni field must be set')
        user = self.model(document=document, **extra_fields)
        user.set_password(password)
        user.save(using=self.db)

        return user
    
    def create_superuser(self, document, password):
        user = self.create_user(document, password)
        user.is_staff = True
        user.is_superuser = True
        user.save(using=self._db)

        return user
        
    

# Creacion de perfil de usuario regular
class User(AbstractBaseUser, PermissionsMixin):
    ROLE_CHOISES = (
        ('APRENDIZ', 'Aprendiz'),
        ('INSTRUCTOR', 'Instructor'),
        ('COORDINACION', 'Coordinacion'),
        ('BIENESTAR', 'Bienestar'),
    )
    document = models.IntegerField(unique=True)
    name = models.CharField(max_length=45)
    role = models.CharField(max_length=45, choices=ROLE_CHOISES)
    is_staff = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)

    objects = UserProfileManager()

    USERNAME_FIELD = 'document'

    def __str__(self):
            return f'{self.name}'