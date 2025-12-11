#!/bin/bash

################################################################################
# BOOT.SH - Script de Arranque de DevDeb
################################################################################
# Descripción:
#   Este es el script de entrada principal que inicia todo el proceso de
#   instalación de DevDeb. Se ejecuta típicamente con:
#   wget -qO- https://devdeb.org/install | bash
#
# Funciones:
#   1. Muestra el logo ASCII de DevDeb con colores
#   2. Verifica que el sistema sea Debian 13 (Trixie)
#   3. Actualiza los repositorios APT
#   4. Instala git (necesario para clonar el repositorio)
#   5. Clona el repositorio de DevDeb en ~/.local/share/devdeb
#   6. Permite cambiar de rama si se especifica DEVDEB_REF
#   7. Ejecuta el instalador principal (install.sh)
#
# Variables de entorno:
#   DEVDEB_REF: Rama o tag a usar (por defecto: stable)
#
# Notas:
#   - Diseñado específicamente para Debian 13 (Trixie)
#   - Verifica compatibilidad en check-version.sh
#   - Los paquetes deben estar disponibles en repositorios Debian
################################################################################

# Salir inmediatamente si un comando falla
set -e

# Arte ASCII del logo de DevDeb
ascii_art='
  ____             ____       __  
 |  _ \  _____   _|  _ \  ___| |__ 
 | | | |/ _ \ \ / / | | |/ _ \ '\''_ \
 | |_| |  __/\ V /| |_| |  __/ |_) |
 |____/ \___| \_/ |____/ \___|_.__/

'

# Mostrar el logo ASCII
echo -e "$ascii_art"

# Mensaje de advertencia sobre compatibilidad
echo "=> DevDeb is for fresh Debian 13 (Trixie) installations only!"
echo -e "\nBegin installation (or abort with ctrl+c)..."

# Actualizar la lista de paquetes disponibles (silenciosamente)
sudo apt-get update >/dev/null

# Instalar git (necesario para clonar el repositorio)
sudo apt-get install -y git >/dev/null

echo "Cloning DevDeb..."

# Eliminar instalación previa si existe
rm -rf ~/.local/share/devdeb

# Clonar el repositorio de DevDeb en el directorio local del usuario
git clone https://github.com/scaballeroq/devdeb.git ~/.local/share/devdeb >/dev/null

# Si se especificó una rama/tag diferente a master, cambiar a ella
if [[ $DEVDEB_REF != "master" ]]; then
	cd ~/.local/share/devdeb
	# Obtener la rama especificada (por defecto: stable) y cambiar a ella
	git fetch origin "${DEVDEB_REF:-stable}" && git checkout "${DEVDEB_REF:-stable}"
	cd -
fi

echo "Installation starting..."

# Ejecutar el script de instalación principal
source ~/.local/share/devdeb/install.sh
