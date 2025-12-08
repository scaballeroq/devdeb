#!/bin/bash

################################################################################
# A-SHELL.SH - Configuración del Shell Bash
################################################################################
# Descripción:
#   Este script configura el shell Bash con las configuraciones predeterminadas
#   de Omakub. Es el primer script que se ejecuta en la instalación de terminal
#   (de ahí el prefijo 'a-').
#
# Archivos configurados:
#   1. ~/.bashrc: Configuración principal de Bash
#   2. ~/.inputrc: Configuración de readline (autocompletado, historial)
#
# Funcionalidades de la configuración de Omakub:
#   - Aliases útiles
#   - Prompt personalizado
#   - Integración con Mise
#   - Configuración de historial mejorada
#   - Autocompletado avanzado
#   - Variables de entorno
#
# Comportamiento:
#   - Respalda archivos existentes con extensión .bak
#   - Copia configuraciones de Omakub
#   - Carga el PATH para uso en instaladores posteriores
#
# Archivos de respaldo:
#   ~/.bashrc.bak: Respaldo del bashrc original
#   ~/.inputrc.bak: Respaldo del inputrc original
################################################################################

# Configurar el shell Bash usando configuraciones predeterminadas de Omakub

# Si existe un .bashrc previo, hacer respaldo
[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.bak

# Copiar la configuración de bashrc de Omakub
# Este archivo incluye:
# - Aliases útiles (ll, la, etc.)
# - Configuración de prompt
# - Integración con herramientas (mise, docker, etc.)
# - Variables de entorno
cp ~/.local/share/omakub/configs/bashrc ~/.bashrc

# Cargar el PATH para uso en instaladores posteriores
# Esto asegura que las herramientas instaladas estén disponibles
# inmediatamente en los scripts siguientes
source ~/.local/share/omakub/defaults/bash/shell

# Si existe un .inputrc previo, hacer respaldo
[ -f ~/.inputrc ] && mv ~/.inputrc ~/.inputrc.bak

# Configurar inputrc usando configuraciones predeterminadas de Omakub
# inputrc controla el comportamiento de readline:
# - Autocompletado case-insensitive
# - Navegación en historial mejorada
# - Búsqueda incremental
# - Atajos de teclado útiles
cp ~/.local/share/omakub/configs/inputrc ~/.inputrc

# Los cambios en bashrc se aplicarán en la próxima sesión de terminal
# o ejecutando: source ~/.bashrc
# Los cambios en inputrc se aplican inmediatamente en nuevas sesiones
