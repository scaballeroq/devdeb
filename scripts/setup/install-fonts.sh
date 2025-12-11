#!/usr/bin/env bash

################################################################################
# INSTALL-FONTS.SH - Instalación de Fuentes para Debian 13 Trixie
################################################################################
# Descripción:
#   Script para instalar fuentes del sistema y Nerd Fonts para terminales
#   modernas. Las fuentes se instalan en ~/.local/share/fonts y se organizan
#   por nombre de fuente.
#
# Uso:
#   ./scripts/setup/install-fonts.sh
#
# Fuentes instaladas:
#   - Fuentes del sistema (Ubuntu, Microsoft Core Fonts)
#   - Nerd Fonts (JetBrains Mono, Fira Code, Cascadia Code, Meslo, Hack)
#
# Autor: DevDeb
# Fecha: 2025-12-09
################################################################################

set -e  # Salir si hay algún error

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Funciones de utilidad
print_header() {
    echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1" >&2
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_step() {
    echo -e "${MAGENTA}→${NC} $1"
}

# Directorios
FONTS_DIR="$HOME/.local/share/fonts"
TEMP_DIR="/tmp/devdeb-fonts"
NERD_FONTS_VERSION="v3.1.1"

print_header "INSTALACIÓN DE FUENTES - DEBIAN 13 TRIXIE"

################################################################################
# 1. FUENTES DEL SISTEMA
################################################################################
print_header "1. INSTALANDO FUENTES DEL SISTEMA"

print_info "Instalando fuentes básicas..."
# fonts-freefont-ttf: Fuentes libres TrueType
# fonts-freefont-otf: Fuentes libres OpenType
# fonts-ubuntu: Fuentes de Ubuntu (modernas y legibles)
sudo apt install -y fonts-freefont-ttf fonts-freefont-otf fonts-ubuntu
print_success "Fuentes básicas instaladas"

print_info "Instalando Microsoft Core Fonts..."
# ttf-mscorefonts-installer: Arial, Times New Roman, Courier, etc.
# Necesario para compatibilidad con documentos de Windows
echo "Aceptando licencia de Microsoft Core Fonts..."
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
sudo apt install -y ttf-mscorefonts-installer
print_success "Microsoft Core Fonts instaladas"

################################################################################
# 2. PREPARAR DIRECTORIOS
################################################################################
print_header "2. PREPARANDO DIRECTORIOS"

print_info "Creando estructura de directorios..."
mkdir -p "$FONTS_DIR"
mkdir -p "$TEMP_DIR"
print_success "Directorios creados: $FONTS_DIR"

################################################################################
# 3. NERD FONTS
################################################################################
print_header "3. INSTALANDO NERD FONTS"

print_info "Las Nerd Fonts incluyen iconos y símbolos para terminales modernas"
print_info "Versión: $NERD_FONTS_VERSION"
echo ""

# Array de Nerd Fonts a instalar
declare -A NERD_FONTS=(
    ["JetBrainsMono"]="JetBrains Mono - Fuente para programación con ligaduras"
    ["FiraCode"]="Fira Code - Fuente con ligaduras de programación"
    ["CascadiaCode"]="Cascadia Code - Fuente de Microsoft para terminal"
    ["Meslo"]="Meslo - Recomendada por Powerlevel10k"
    ["Hack"]="Hack - Fuente diseñada para código fuente"
)

# Función para descargar e instalar Nerd Font
install_nerd_font() {
    local font_name="$1"
    local font_desc="$2"
    
    print_step "Instalando $font_name..."
    print_info "  $font_desc"
    
    # URL de descarga
    local download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/${NERD_FONTS_VERSION}/${font_name}.zip"
    local zip_file="$TEMP_DIR/${font_name}.zip"
    local extract_dir="$FONTS_DIR/NerdFonts/${font_name}"
    
    # Crear directorio de destino
    mkdir -p "$extract_dir"
    
    # Descargar fuente
    print_info "  Descargando..."
    if wget -q --show-progress "$download_url" -O "$zip_file"; then
        print_success "  Descargado"
    else
        print_error "  Error al descargar $font_name"
        return 1
    fi
    
    # Extraer fuente
    print_info "  Extrayendo..."
    unzip -q -o "$zip_file" -d "$extract_dir"
    
    # Limpiar archivos innecesarios
    find "$extract_dir" -name "*.txt" -delete
    find "$extract_dir" -name "*.md" -delete
    find "$extract_dir" -name "LICENSE*" -delete
    
    # Eliminar archivo zip
    rm "$zip_file"
    
    print_success "  $font_name instalada en $extract_dir"
}

# Instalar cada Nerd Font
for font_name in "${!NERD_FONTS[@]}"; do
    install_nerd_font "$font_name" "${NERD_FONTS[$font_name]}"
    echo ""
done

################################################################################
# 4. COPIAR FUENTES ADICIONALES (si existen)
################################################################################
print_header "4. BUSCANDO FUENTES ADICIONALES"

# Buscar carpeta 'font' o 'fonts' en el proyecto
DEVDEB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
FONT_SOURCES=(
    "$DEVDEB_DIR/font"
    "$DEVDEB_DIR/fonts"
    "$DEVDEB_DIR/assets/font"
    "$DEVDEB_DIR/assets/fonts"
)

found_fonts=false
for source_dir in "${FONT_SOURCES[@]}"; do
    if [ -d "$source_dir" ]; then
        print_info "Encontradas fuentes en: $source_dir"
        
        # Copiar fuentes organizándolas por tipo
        for font_file in "$source_dir"/*; do
            if [ -f "$font_file" ]; then
                filename=$(basename "$font_file")
                extension="${filename##*.}"
                
                # Solo copiar archivos de fuentes
                if [[ "$extension" =~ ^(ttf|otf|TTF|OTF)$ ]]; then
                    # Extraer nombre de la fuente del archivo
                    font_family=$(echo "$filename" | sed 's/[-_].*//' | sed 's/\..*//')
                    dest_dir="$FONTS_DIR/Custom/$font_family"
                    
                    mkdir -p "$dest_dir"
                    cp "$font_file" "$dest_dir/"
                    print_success "  Copiada: $filename → $dest_dir"
                    found_fonts=true
                fi
            fi
        done
    fi
done

if [ "$found_fonts" = false ]; then
    print_info "No se encontraron fuentes adicionales en el proyecto"
    print_info "Puedes añadir fuentes manualmente en: $FONTS_DIR/Custom/"
fi

################################################################################
# 5. ACTUALIZAR CACHÉ DE FUENTES
################################################################################
print_header "5. ACTUALIZANDO CACHÉ DE FUENTES"

print_info "Actualizando caché del sistema..."
fc-cache -fv | grep -E "^fc-cache|succeeded|failed" || true
print_success "Caché de fuentes actualizado"

################################################################################
# 6. VERIFICACIÓN
################################################################################
print_header "6. VERIFICACIÓN DE INSTALACIÓN"

print_info "Fuentes instaladas en el sistema:"
fc-list | grep -i "nerd\|jetbrains\|fira\|cascadia\|meslo\|hack" | wc -l | xargs echo "  • Nerd Fonts:"
fc-list | grep -i "ubuntu" | wc -l | xargs echo "  • Ubuntu Fonts:"
fc-list | grep -i "arial\|times\|courier" | wc -l | xargs echo "  • Microsoft Core Fonts:"

echo ""
print_info "Estructura de directorios:"
tree -L 2 "$FONTS_DIR" 2>/dev/null || find "$FONTS_DIR" -maxdepth 2 -type d | sed 's|^|  |'

################################################################################
# 7. LIMPIEZA
################################################################################
print_header "7. LIMPIEZA"

print_info "Limpiando archivos temporales..."
rm -rf "$TEMP_DIR"
print_success "Archivos temporales eliminados"

################################################################################
# 8. RESUMEN FINAL
################################################################################
print_header "INSTALACIÓN COMPLETADA"

echo -e "${GREEN}✓ Fuentes del sistema instaladas${NC}"
echo -e "${GREEN}✓ Nerd Fonts instaladas (5 fuentes)${NC}"
echo -e "${GREEN}✓ Caché de fuentes actualizado${NC}"
echo ""

print_info "Fuentes instaladas:"
echo "  📁 $FONTS_DIR"
echo "     ├── NerdFonts/"
echo "     │   ├── JetBrainsMono/"
echo "     │   ├── FiraCode/"
echo "     │   ├── CascadiaCode/"
echo "     │   ├── Meslo/"
echo "     │   └── Hack/"
echo "     └── Custom/ (si añadiste fuentes adicionales)"
echo ""

print_warning "CONFIGURACIÓN DE TERMINAL:"
echo "  1. Abre tu terminal (GNOME Terminal, Alacritty, etc.)"
echo "  2. Ve a Preferencias → Perfil → Fuente"
echo "  3. Selecciona una Nerd Font (ejemplo: JetBrainsMono Nerd Font)"
echo "  4. Tamaño recomendado: 11-13"
echo ""

print_info "Fuentes recomendadas para terminal:"
echo "  • JetBrains Mono Nerd Font - Mejor para programación"
echo "  • Fira Code Nerd Font - Ligaduras hermosas"
echo "  • Cascadia Code Nerd Font - Moderna de Microsoft"
echo "  • Meslo Nerd Font - Recomendada por Powerlevel10k"
echo ""

print_info "Para ZSH con Powerlevel10k:"
echo "  1. Ejecuta: p10k configure"
echo "  2. Selecciona 'Meslo Nerd Font' cuando pregunte"
echo ""

print_success "¡Fuentes instaladas correctamente! 🎨"
