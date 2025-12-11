#!/usr/bin/env bash
# Ejemplo: Crear una webapp personalizada usando DevDeb

# Cargar funciones de DevDeb
DEVDEB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DEVDEB_DIR/scripts/shell/functions.sh"

# Ejemplo 1: Crear webapp de GitHub
echo "Creando webapp de GitHub..."
web2app 'GitHub' \
    https://github.com \
    https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/github.png

# Ejemplo 2: Crear webapp de Stack Overflow
echo "Creando webapp de Stack Overflow..."
web2app 'Stack Overflow' \
    https://stackoverflow.com \
    https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/stackoverflow.png

# Ejemplo 3: Crear webapp personalizada con icono local
# web2app 'Mi App' \
#     https://miapp.com \
#     /ruta/a/mi/icono.png

echo "¡Webapps creadas exitosamente!"
