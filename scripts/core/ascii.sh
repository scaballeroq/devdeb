#!/bin/bash

################################################################################
# ASCII.SH - Generador de Logo ASCII con Degradado de Colores
################################################################################
# Descripción:
#   Este script muestra el logo de DevDeb en arte ASCII con un degradado
#   de colores que va desde cyan hasta azul.
#
# Funcionalidad:
#   - Define el arte ASCII del logo
#   - Crea un array de colores en degradado (7 tonos de cyan a azul)
#   - Divide el arte ASCII en líneas
#   - Imprime cada línea con un color diferente del degradado
#   - Usa códigos de escape ANSI para los colores
#
# Uso:
#   ./ascii.sh
#   source ascii.sh
#
# Colores utilizados (códigos ANSI 256):
#   81 - Cyan brillante
#   75 - Azul claro
#   69 - Azul cielo
#   63 - Azul dodger
#   57 - Azul cielo profundo
#   51 - Azul aciano
#   45 - Azul real
################################################################################

# Arte ASCII del logo de DevDeb
ascii_art='
________                  __        ___.
\_____  \   _____ _____  |  | ____ _\_ |__
 /   |   \ /     \\__   \ |  |/ /  |  \ __ \
/    |    \  Y Y  \/ __ \|    <|  |  / \_\ \
\_______  /__|_|  (____  /__|_ \____/|___  /
        \/      \/     \/     \/         \/

'

# Definir el degradado de colores (tonos de cyan y azul)
# Formato: \033[38;5;Nm donde N es el código de color de 256 colores
colors=(
	'\033[38;5;81m' # Cyan
	'\033[38;5;75m' # Light Blue (Azul claro)
	'\033[38;5;69m' # Sky Blue (Azul cielo)
	'\033[38;5;63m' # Dodger Blue (Azul dodger)
	'\033[38;5;57m' # Deep Sky Blue (Azul cielo profundo)
	'\033[38;5;51m' # Cornflower Blue (Azul aciano)
	'\033[38;5;45m' # Royal Blue (Azul real)
)

# Dividir el arte ASCII en líneas individuales
# IFS=$'\n' establece el separador de campo interno a nueva línea
# read -rd '' lee hasta encontrar un carácter nulo
# -a lines almacena el resultado en un array
IFS=$'\n' read -rd '' -a lines <<<"$ascii_art"

# Imprimir cada línea con el color correspondiente del degradado
for i in "${!lines[@]}"; do
	# Calcular el índice del color usando módulo para ciclar los colores
	color_index=$((i % ${#colors[@]}))
	# Imprimir la línea con el color correspondiente
	# -e habilita la interpretación de secuencias de escape
	echo -e "${colors[color_index]}${lines[i]}"
done
