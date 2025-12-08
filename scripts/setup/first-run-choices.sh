#!/bin/bash

################################################################################
# FIRST-RUN-CHOICES.SH - Selección Interactiva de Componentes
################################################################################
# Descripción:
#   Este script presenta al usuario opciones interactivas para seleccionar
#   qué componentes desea instalar durante la primera ejecución.
#
# Componentes seleccionables:
#   1. Aplicaciones opcionales de escritorio (solo en GNOME)
#   2. Lenguajes de programación
#   3. Bases de datos (ejecutadas en Docker)
#
# Herramienta utilizada:
#   gum: Herramienta CLI para crear interfaces de usuario interactivas
#   https://github.com/charmbracelet/gum
#
# Variables de entorno exportadas:
#   DEVDEB_FIRST_RUN_OPTIONAL_APPS: Apps opcionales seleccionadas
#   DEVDEB_FIRST_RUN_LANGUAGES: Lenguajes seleccionados
#   DEVDEB_FIRST_RUN_DBS: Bases de datos seleccionadas
#
# Estas variables son utilizadas por scripts posteriores para instalar
# solo los componentes seleccionados.
################################################################################

# Solo preguntar por aplicaciones de escritorio si estamos en GNOME
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
  # Definir lista de aplicaciones opcionales disponibles
  OPTIONAL_APPS=("1password" "Spotify" "Zoom" "Dropbox")
  
  # Aplicaciones seleccionadas por defecto (pre-marcadas en la interfaz)
  DEFAULT_OPTIONAL_APPS='1password,Spotify,Zoom'
  
  # Mostrar selector interactivo con gum
  # --no-limit: Permite seleccionar múltiples opciones
  # --selected: Pre-selecciona las opciones por defecto
  # --height 7: Altura de la ventana de selección
  # --header: Texto mostrado en la parte superior
  # tr ' ' '-': Reemplaza espacios por guiones en los nombres
  export DEVDEB_FIRST_RUN_OPTIONAL_APPS=$(gum choose "${OPTIONAL_APPS[@]}" --no-limit --selected $DEFAULT_OPTIONAL_APPS --height 7 --header "Select optional apps" | tr ' ' '-')
fi

# Selección de lenguajes de programación
# Disponibles: Ruby on Rails, Node.js, Go, PHP, Python, Elixir, Rust, Java
AVAILABLE_LANGUAGES=("Ruby on Rails" "Node.js" "Go" "PHP" "Python" "Elixir" "Rust" "Java")

# Lenguajes pre-seleccionados por defecto
SELECTED_LANGUAGES="Ruby on Rails","Node.js"

# Mostrar selector de lenguajes
export DEVDEB_FIRST_RUN_LANGUAGES=$(gum choose "${AVAILABLE_LANGUAGES[@]}" --no-limit --selected "$SELECTED_LANGUAGES" --height 10 --header "Select programming languages")

# Selección de bases de datos
# Todas se ejecutarán en contenedores Docker
AVAILABLE_DBS=("MySQL" "Redis" "PostgreSQL")

# Bases de datos pre-seleccionadas por defecto
SELECTED_DBS="MySQL,Redis"

# Mostrar selector de bases de datos
export DEVDEB_FIRST_RUN_DBS=$(gum choose "${AVAILABLE_DBS[@]}" --no-limit --selected "$SELECTED_DBS" --height 5 --header "Select databases (runs in Docker)")

# Las variables exportadas estarán disponibles para los scripts de instalación
# que se ejecuten posteriormente en el mismo proceso
