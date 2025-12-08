#!/bin/bash

################################################################################
# INSTALL.SH - Script Principal de Instalación de Omakub
################################################################################
# Descripción:
#   Este es el script principal que coordina toda la instalación de Omakub.
#   Se ejecuta después de boot.sh y maneja la instalación de componentes
#   tanto de terminal como de escritorio.
#
# Flujo de ejecución:
#   1. Verifica la versión del sistema operativo
#   2. Configura manejo de errores para permitir reintentos
#   3. Instala 'gum' (herramienta para interfaces interactivas)
#   4. Solicita al usuario que elija aplicaciones, lenguajes y bases de datos
#   5. Solicita información de identificación (nombre y email para git)
#   6. Detecta si está ejecutándose en GNOME
#   7. Si es GNOME: desactiva suspensión/bloqueo durante instalación
#   8. Instala herramientas de terminal
#   9. Si es GNOME: instala aplicaciones de escritorio y configuraciones
#   10. Si es GNOME: restaura configuración de suspensión/bloqueo
#   11. Si no es GNOME: solo instala herramientas de terminal
#
# Variables de entorno utilizadas:
#   XDG_CURRENT_DESKTOP: Detecta el entorno de escritorio actual
#   DEVDEB_FIRST_RUN_OPTIONAL_APPS: Apps opcionales seleccionadas
#   DEVDEB_FIRST_RUN_LANGUAGES: Lenguajes de programación seleccionados
#   DEVDEB_FIRST_RUN_DBS: Bases de datos seleccionadas
#   DEVDEB_USER_NAME: Nombre completo del usuario
#   DEVDEB_USER_EMAIL: Email del usuario
#
# Notas para Debian:
#   - El script funciona igual en Debian
#   - Verificar que 'gum' esté disponible o instalarlo manualmente
#   - Algunas configuraciones de GNOME pueden variar según la versión
################################################################################

# Salir inmediatamente si un comando falla
set -e

# Configurar trap para capturar errores y dar oportunidad de reintentar
# Si algo falla, muestra este mensaje con instrucciones de reintento
trap 'echo "Omakub installation failed! You can retry by running: source ~/.local/share/omakub/install.sh"' ERR

# Verificar la distribución y versión del sistema operativo
# Este script abortará si no es Ubuntu 24.04+ (adaptar para Debian)
source ~/.local/share/omakub/install/check-version.sh

# Solicitar al usuario que elija aplicaciones y configuraciones
echo "Get ready to make a few choices..."

# Instalar 'gum' - herramienta para crear interfaces de usuario en terminal
# Se instala primero porque se usa en los siguientes scripts
source ~/.local/share/omakub/install/terminal/required/app-gum.sh >/dev/null

# Solicitar elección de aplicaciones opcionales, lenguajes y bases de datos
source ~/.local/share/omakub/install/first-run-choices.sh

# Solicitar nombre y email del usuario (para configuración de git)
source ~/.local/share/omakub/install/identification.sh

# Las aplicaciones de escritorio y ajustes solo se instalan si estamos en GNOME
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
  # Asegurar que el ordenador no se suspenda ni bloquee durante la instalación
  # Esto evita interrupciones durante el proceso que puede durar varios minutos
  gsettings set org.gnome.desktop.screensaver lock-enabled false
  gsettings set org.gnome.desktop.session idle-delay 0

  echo "Installing terminal and desktop tools..."

  # Instalar herramientas de terminal (shell, docker, editores, etc.)
  source ~/.local/share/omakub/install/terminal.sh

  # Instalar herramientas de escritorio (aplicaciones GUI, temas, extensiones)
  source ~/.local/share/omakub/install/desktop.sh

  # Revertir a la configuración normal de suspensión y bloqueo
  # Bloqueo activado después de 5 minutos (300 segundos) de inactividad
  gsettings set org.gnome.desktop.screensaver lock-enabled true
  gsettings set org.gnome.desktop.session idle-delay 300
else
  # Si no estamos en GNOME, solo instalar herramientas de terminal
  # Esto es útil para servidores o sistemas con otros entornos de escritorio
  echo "Only installing terminal tools..."
  source ~/.local/share/omakub/install/terminal.sh
fi
