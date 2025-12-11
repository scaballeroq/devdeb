#!/bin/bash

################################################################################
# DOCKER.SH - Instalación y Configuración de Docker
################################################################################
# Descripción:
#   Este script instala Docker Engine y sus componentes relacionados desde
#   el repositorio oficial de Docker. También configura el sistema para un
#   uso óptimo de Docker.
#
# Componentes instalados:
#   - docker-ce: Docker Community Edition (motor principal)
#   - docker-ce-cli: Interfaz de línea de comandos
#   - containerd.io: Runtime de contenedores
#   - docker-buildx-plugin: Constructor de imágenes multi-plataforma
#   - docker-compose-plugin: Orquestación de múltiples contenedores
#   - docker-ce-rootless-extras: Soporte para Docker sin root
#   - lazydocker: Interfaz de terminal para Docker
#
# Configuraciones aplicadas:
#   1. Añade el usuario actual al grupo docker (acceso sin sudo)
#   2. Limita el tamaño de logs (10MB por archivo, máximo 5 archivos)
#
# Adaptaciones para Debian:
#   - URL configurada para Debian (https://download.docker.com/linux/debian/)
#   - Compatible con versiones recientes (bookworm, trixie, etc.)
#
# Nota importante:
#   Después de la instalación, es necesario cerrar sesión y volver a entrar
#   para que los cambios de grupo surtan efecto.
################################################################################

# Añadir el repositorio oficial de Docker si no existe
if [ ! -f /etc/apt/sources.list.d/docker.list ]; then
    # Eliminar clave GPG antigua si existe
    [ -f /etc/apt/keyrings/docker.asc ] && sudo rm /etc/apt/keyrings/docker.asc
    
    # Crear directorio para claves GPG con permisos adecuados
    sudo install -m 0755 -d /etc/apt/keyrings
    
    # Descargar la clave GPG oficial de Docker
    # Descargar la clave GPG oficial de Docker
    sudo wget -qO /etc/apt/keyrings/docker.asc https://download.docker.com/linux/debian/gpg
    
    # Hacer la clave legible para todos los usuarios
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    
    # Añadir el repositorio de Docker a las fuentes de APT
    # $(dpkg --print-architecture): Detecta la arquitectura (amd64, arm64, etc.)
    # $(. /etc/os-release && echo "$VERSION_CODENAME"): Obtiene el nombre de la versión (jammy, noble, etc.)
    # Configurar el repositorio para Debian
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
fi

# Actualizar la lista de paquetes con el nuevo repositorio
sudo apt update

# Instalar Docker Engine y todos los plugins estándar
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras

# Instalar Lazydocker
# https://github.com/jesseduffield/lazydocker
echo "Instalando Lazydocker..."
LAZYDOCKER_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/')
curl -Lo lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/download/v${LAZYDOCKER_VERSION}/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz"
sudo tar xf lazydocker.tar.gz lazydocker
sudo install lazydocker /usr/local/bin
rm lazydocker.tar.gz lazydocker

# Dar al usuario actual acceso privilegiado a Docker
# Esto permite ejecutar comandos docker sin sudo
# IMPORTANTE: Requiere cerrar sesión y volver a entllarar para que surta efecto
sudo usermod -aG docker ${USER}

# Limitar el tamaño de los logs para evitar quedarse sin espacio en disco
# Configuración:
#   - log-driver: json-file (formato de logs)
#   - max-size: 10m (máximo 10 megabytes por archivo de log)
#   - max-file: 5 (mantener máximo 5 archivos de log rotados)
# Total máximo de logs por contenedor: 50MB (10MB × 5 archivos)
echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"5"}}' | sudo tee /etc/docker/daemon.json

# Nota: Para aplicar la configuración de logs, reiniciar el servicio Docker:
# sudo systemctl restart docker
