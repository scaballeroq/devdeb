#!/bin/bash

################################################################################
# IDENTIFICATION.SH - Configuración de Identidad del Usuario
################################################################################
# Descripción:
#   Este script solicita al usuario su nombre completo y dirección de email.
#   Esta información se utiliza para:
#   - Configurar git (commits, autor)
#   - Autocompletado en diversas herramientas
#   - Personalización del entorno
#
# Variables de entorno exportadas:
#   DEVDEB_USER_NAME: Nombre completo del usuario
#   DEVDEB_USER_EMAIL: Dirección de email del usuario
#
# Herramienta utilizada:
#   gum input: Solicita entrada de texto al usuario con interfaz mejorada
#
# Uso posterior:
#   Estas variables son utilizadas por set-git.sh para configurar:
#   - git config --global user.name
#   - git config --global user.email
################################################################################

echo "Enter identification for git and autocomplete..."

# Obtener el nombre completo del usuario desde el sistema
# getent passwd obtiene la entrada del usuario en /etc/passwd
# cut -d ':' -f 5 extrae el campo 5 (nombre completo/GECOS)
# cut -d ',' -f 1 toma solo la primera parte (antes de la coma)
SYSTEM_NAME=$(getent passwd "$USER" | cut -d ':' -f 5 | cut -d ',' -f 1)

# Solicitar nombre completo con gum
# --placeholder: Texto de ayuda mostrado cuando el campo está vacío
# --value: Valor por defecto (nombre del sistema)
# --prompt: Texto mostrado antes del campo de entrada
export DEVDEB_USER_NAME=$(gum input --placeholder "Enter full name" --value "$SYSTEM_NAME" --prompt "Name> ")

# Solicitar dirección de email
# No hay valor por defecto, el usuario debe ingresarlo
export DEVDEB_USER_EMAIL=$(gum input --placeholder "Enter email address" --prompt "Email> ")

# Las variables exportadas estarán disponibles para scripts posteriores
# especialmente para la configuración de git
