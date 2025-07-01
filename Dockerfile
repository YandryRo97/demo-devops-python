FROM python:3.11-slim

# Crear usuario
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

# Variables de entorno
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Directorio de trabajo
WORKDIR /app

# Copiar archivos
COPY . .

# Instalar dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Dar permisos a db.sqlite3
RUN touch db.sqlite3 && chmod 664 db.sqlite3

# Exponer el puerto
EXPOSE 8000

# Cambiar a usuario seguro
USER appuser

# Ejecutar Django
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
