#!/bin/bash

################################################################################
# BOOT.SH - Script de Arranque de Omakub
################################################################################
# Descripción:
#   Este es el script de entrada principal que inicia todo el proceso de
#   instalación de Omakub. Se ejecuta típicamente con:
#   wget -qO- https://omakub.org/install | bash
#
# Funciones:
#   1. Muestra el logo ASCII de Omakub con colores
#   2. Verifica que el sistema sea Ubuntu 24.04+ (adaptar para Debian)
#   3. Actualiza los repositorios APT
#   4. Instala git (necesario para clonar el repositorio)
#   5. Clona el repositorio de Omakub en ~/.local/share/omakub
#   6. Permite cambiar de rama si se especifica DEVDEB_REF
#   7. Ejecuta el instalador principal (install.sh)
#
# Variables de entorno:
#   DEVDEB_REF: Rama o tag a usar (por defecto: stable)
#
# Adaptaciones para Debian:
#   - Cambiar verificación de Ubuntu a Debian en check-version.sh
#   - Verificar que los paquetes estén disponibles en repositorios Debian
################################################################################

# Salir inmediatamente si un comando falla
set -e

# Arte ASCII del logo de Omakub
ascii_art='________                  __        ___.
\_____  \   _____ _____  |  | ____ _\_ |__
 /   |   \ /     \\__   \ |  |/ /  |  \ __ \
/    |    \  Y Y  \/ __ \|    <|  |  / \_\ \
\_______  /__|_|  (____  /__|_ \____/|___  /
        \/      \/     \/     \/         \/
'

# Mostrar el logo ASCII
echo -e "$ascii_art"

# Mensaje de advertencia sobre compatibilidad
echo "=> Omakub is for fresh Ubuntu 24.04+ installations only!"
echo -e "\nBegin installation (or abort with ctrl+c)..."

# Actualizar la lista de paquetes disponibles (silenciosamente)
sudo apt-get update >/dev/null

# Instalar git (necesario para clonar el repositorio)
sudo apt-get install -y git >/dev/null

echo "Cloning Omakub..."

# Eliminar instalación previa si existe
rm -rf ~/.local/share/omakub

# Clonar el repositorio de Omakub en el directorio local del usuario
git clone https://github.com/basecamp/omakub.git ~/.local/share/omakub >/dev/null

# Si se especificó una rama/tag diferente a master, cambiar a ella
if [[ $DEVDEB_REF != "master" ]]; then
	cd ~/.local/share/omakub
	# Obtener la rama especificada (por defecto: stable) y cambiar a ella
	git fetch origin "${DEVDEB_REF:-stable}" && git checkout "${DEVDEB_REF:-stable}"
	cd -
fi

echo "Installation starting..."

# Ejecutar el script de instalación principal
source ~/.local/share/omakub/install.sh
