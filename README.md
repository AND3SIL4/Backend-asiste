# API de Automatización para el Centro Formativo del SENA (Año 2023)

Este proyecto consiste en una API construida en Django para automatizar el proceso de llamado a asistencia, novedades y reportes en un centro formativo del SENA en Bogotá, Colombia para el año 2023.

## Tabla de Contenidos

1. [Descripción](#descripcion)
2. [Características](#caracteristicas)
3. [Tecnologías Utilizadas](#tecnologias-utilizadas)
4. [Configuración del Entorno de Desarrollo](#configuracion-del-entorno-de-desarrollo)
5. [Instalación y Configuración](#instalacion-y-configuracion)
6. [Uso](#uso)
7. [Contribución](#contribucion)
8. [Licencia](#licencia)

## Descripción <a name="descripcion"></a>

Este proyecto tiene como objetivo automatizar el proceso de llamado a asistencia, registro de novedades y generación de reportes para un centro formativo del SENA en Bogotá, Colombia, con el fin de mejorar la eficiencia en la gestión de información y optimizar los procesos internos.

## Características <a name="caracteristicas"></a>

- **Llamado a Asistencia**: Permite registrar la asistencia de los estudiantes y docentes de manera automatizada.
- **Registro de Novedades**: Facilita el registro de novedades y situaciones especiales en tiempo real.
- **Generación de Reportes**: Permite generar reportes detallados sobre la asistencia y novedades para su análisis.

## Tecnologías Utilizadas <a name="tecnologias-utilizadas"></a>

- Django
- Django REST Framework
- MySql
- Python
- Git

## Configuración del Entorno de Desarrollo <a name="configuracion-del-entorno-de-desarrollo"></a>

Para configurar el entorno de desarrollo, se requiere tener Python y pip instalados. Se recomienda utilizar un entorno virtual para gestionar las dependencias.

```bash
# Crear un entorno virtual
virtualenv virt

# Activar el entorno virtual
./virt/bin/activate # En windows

# Instalar las dependencias
pip install -r requirements.txt

# Crear base de datos ejecutando python script
pyhon db.py

# Despues de crear base de datos
## configurar el archivo settings.py en el root del proyecto
### actualizar parametros para conexion con la base de datos (user, password, host, port)

# Crear migraciones
python ./manage.py makemigrations

# Migrar estructura a base de datos
python ./manage.py migrate

# Crear superuser
python ./manage.py createsuperuser

# Ejecutar el servidor backend
python ./manage.py runserver 0:8080 # utilice el puerto de su preferencia 
