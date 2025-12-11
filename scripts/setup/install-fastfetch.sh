#!/usr/bin/env bash

################################################################################
# INSTALL-FASTFETCH.SH - Instalación y Configuración de Fastfetch
################################################################################
# Descripción:
#   Script para instalar Fastfetch (herramienta moderna de información del
#   sistema) y aplicar configuración personalizada con diseño mejorado.
#
# Uso:
#   ./scripts/setup/install-fastfetch.sh
#
# Requisitos:
#   - Debian 13 Trixie
#
# Componentes:
#   - Fastfetch: Herramienta de información del sistema (alternativa a neofetch)
#   - Configuración personalizada con secciones organizadas
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

# Obtener el usuario real (si se ejecuta con sudo)
if [ -n "$SUDO_USER" ]; then
    REAL_USER=$SUDO_USER
    REAL_HOME=$(eval echo ~$SUDO_USER)
else
    REAL_USER=$USER
    REAL_HOME=$HOME
fi

print_header "INSTALACIÓN DE FASTFETCH"
print_info "Usuario: $REAL_USER"
echo ""

################################################################################
# 1. INSTALACIÓN DE FASTFETCH
################################################################################
print_header "1. INSTALANDO FASTFETCH"

print_info "Actualizando repositorios..."
if [ "$EUID" -eq 0 ]; then
    apt update -qq
else
    sudo apt update -qq
fi

print_info "Instalando Fastfetch..."
# fastfetch: Herramienta moderna de información del sistema
#   - Mucho más rápida que neofetch (escrita en C)
#   - Altamente configurable con JSON
#   - Soporta múltiples logos y temas
#   - Muestra información detallada del hardware y software
if [ "$EUID" -eq 0 ]; then
    apt install -y fastfetch
else
    sudo apt install -y fastfetch
fi

print_success "Fastfetch instalado"

# Verificar instalación
if command -v fastfetch &> /dev/null; then
    FASTFETCH_VERSION=$(fastfetch --version | head -1)
    print_success "Versión: $FASTFETCH_VERSION"
else
    print_error "Fastfetch no se instaló correctamente"
    exit 1
fi

################################################################################
# 2. GENERACIÓN DE CONFIGURACIÓN POR DEFECTO
################################################################################
print_header "2. GENERANDO CONFIGURACIÓN BASE"

print_info "Creando directorio de configuración..."
sudo -u $REAL_USER mkdir -p "$REAL_HOME/.config/fastfetch"
print_success "Directorio creado: $REAL_HOME/.config/fastfetch"

print_info "Generando configuración por defecto..."
# --gen-config: Genera archivo de configuración base
sudo -u $REAL_USER fastfetch --gen-config
print_success "Configuración base generada"

################################################################################
# 3. APLICAR CONFIGURACIÓN PERSONALIZADA
################################################################################
print_header "3. APLICANDO CONFIGURACIÓN PERSONALIZADA"

# Buscar configuración personalizada en el proyecto
DEVDEB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
CUSTOM_CONFIG="$DEVDEB_DIR/assets/fastfetch/config.jsonc"

if [ -f "$CUSTOM_CONFIG" ]; then
    print_info "Encontrada configuración personalizada"
    print_info "  Origen: $CUSTOM_CONFIG"
    
    # Hacer backup de la configuración por defecto
    if [ -f "$REAL_HOME/.config/fastfetch/config.jsonc" ]; then
        print_step "Creando backup de configuración por defecto..."
        sudo -u $REAL_USER cp "$REAL_HOME/.config/fastfetch/config.jsonc" \
            "$REAL_HOME/.config/fastfetch/config.jsonc.backup"
        print_success "Backup creado: config.jsonc.backup"
    fi
    
    # Copiar configuración personalizada
    print_step "Aplicando configuración personalizada..."
    sudo -u $REAL_USER cp "$CUSTOM_CONFIG" "$REAL_HOME/.config/fastfetch/config.jsonc"
    print_success "Configuración personalizada aplicada"
    
    print_info "Características de la configuración:"
    echo "  • Logo del sistema con padding personalizado"
    echo "  • Sección Hardware (PC, CPU, GPU, RAM, Disco)"
    echo "  • Sección Software (OS, Kernel, BIOS, Paquetes, Shell)"
    echo "  • Sección Desktop (DE, Login Manager, WM, Tema, Terminal)"
    echo "  • Sección Uptime/Age/DateTime"
    echo "  • Paleta de colores al final"
    echo "  • Diseño con bordes y separadores visuales"
else
    print_warning "No se encontró configuración personalizada"
    print_info "Usando configuración por defecto generada"
    print_info "Puedes crear una configuración personalizada en:"
    print_info "  $DEVDEB_DIR/assets/fastfetch/config.jsonc"
fi

################################################################################
# 4. PRUEBA DE FASTFETCH
################################################################################
print_header "4. PROBANDO FASTFETCH"

print_info "Ejecutando Fastfetch con la configuración aplicada..."
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Ejecutar fastfetch como el usuario real
sudo -u $REAL_USER fastfetch

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

print_success "Fastfetch ejecutado correctamente"

################################################################################
# 5. INTEGRACIÓN CON SHELL
################################################################################
print_header "5. INTEGRACIÓN CON SHELL (OPCIONAL)"

print_info "¿Quieres que Fastfetch se ejecute automáticamente al abrir la terminal?"
echo ""

# Detectar shell del usuario
USER_SHELL=$(getent passwd $REAL_USER | cut -d: -f7)
SHELL_RC=""

if [[ "$USER_SHELL" == *"zsh"* ]]; then
    SHELL_RC="$REAL_HOME/.zshrc"
    print_info "Shell detectado: Zsh"
elif [[ "$USER_SHELL" == *"bash"* ]]; then
    SHELL_RC="$REAL_HOME/.bashrc"
    print_info "Shell detectado: Bash"
else
    print_warning "Shell no reconocido: $USER_SHELL"
fi

if [ -n "$SHELL_RC" ]; then
    print_warning "Para añadir Fastfetch al inicio de tu shell, ejecuta:"
    echo ""
    echo "  echo 'fastfetch' >> $SHELL_RC"
    echo ""
    print_info "O añádelo manualmente al final de $SHELL_RC"
fi

################################################################################
# 6. RESUMEN FINAL
################################################################################
print_header "INSTALACIÓN COMPLETADA"

echo -e "${GREEN}✓ Fastfetch instalado${NC}"
echo -e "${GREEN}✓ Configuración personalizada aplicada${NC}"
echo -e "${GREEN}✓ Prueba ejecutada correctamente${NC}"
echo ""

print_info "Ubicaciones importantes:"
echo "  • Ejecutable: $(which fastfetch)"
echo "  • Configuración: $REAL_HOME/.config/fastfetch/config.jsonc"
echo "  • Backup: $REAL_HOME/.config/fastfetch/config.jsonc.backup"
echo ""

print_info "Comandos útiles:"
echo "  • Ejecutar Fastfetch: fastfetch"
echo "  • Ver ayuda: fastfetch --help"
echo "  • Listar logos: fastfetch --list-logos"
echo "  • Listar módulos: fastfetch --list-modules"
echo "  • Generar nueva config: fastfetch --gen-config"
echo "  • Usar logo específico: fastfetch --logo debian"
echo "  • Modo compacto: fastfetch --logo small"
echo ""

print_info "Editar configuración:"
echo "  nano $REAL_HOME/.config/fastfetch/config.jsonc"
echo "  # o"
echo "  gnome-text-editor $REAL_HOME/.config/fastfetch/config.jsonc"
echo ""

print_success "¡Fastfetch listo para usar! 🚀"
