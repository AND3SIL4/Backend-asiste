## Archivo para el acceso a base de datos para hacer CRUD mediante el ingreso admin

from django.contrib import admin
from .models import User

# Register your models here.
admin.site.register(User)