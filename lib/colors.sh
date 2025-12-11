#!/usr/bin/env bash
# DevDeb - Definiciones de colores para terminal
# Este archivo contiene códigos ANSI para colores y estilos de texto

# Colores básicos
export COLOR_RESET='\033[0m'
export COLOR_BLACK='\033[0;30m'
export COLOR_RED='\033[0;31m'
export COLOR_GREEN='\033[0;32m'
export COLOR_YELLOW='\033[0;33m'
export COLOR_BLUE='\033[0;34m'
export COLOR_MAGENTA='\033[0;35m'
export COLOR_CYAN='\033[0;36m'
export COLOR_WHITE='\033[0;37m'

# Colores brillantes
export COLOR_BRIGHT_BLACK='\033[0;90m'
export COLOR_BRIGHT_RED='\033[0;91m'
export COLOR_BRIGHT_GREEN='\033[0;92m'
export COLOR_BRIGHT_YELLOW='\033[0;93m'
export COLOR_BRIGHT_BLUE='\033[0;94m'
export COLOR_BRIGHT_MAGENTA='\033[0;95m'
export COLOR_BRIGHT_CYAN='\033[0;96m'
export COLOR_BRIGHT_WHITE='\033[0;97m'

# Estilos
export STYLE_BOLD='\033[1m'
export STYLE_DIM='\033[2m'
export STYLE_ITALIC='\033[3m'
export STYLE_UNDERLINE='\033[4m'
export STYLE_BLINK='\033[5m'
export STYLE_REVERSE='\033[7m'

# Funciones de impresión con color
print_success() {
    echo -e "${COLOR_GREEN}✓${COLOR_RESET} $1"
}

print_error() {
    echo -e "${COLOR_RED}✗${COLOR_RESET} $1" >&2
}

print_warning() {
    echo -e "${COLOR_YELLOW}⚠${COLOR_RESET} $1"
}

print_info() {
    echo -e "${COLOR_BLUE}ℹ${COLOR_RESET} $1"
}

print_header() {
    echo -e "\n${STYLE_BOLD}${COLOR_CYAN}$1${COLOR_RESET}\n"
}

print_step() {
    echo -e "${COLOR_MAGENTA}→${COLOR_RESET} $1"
}
