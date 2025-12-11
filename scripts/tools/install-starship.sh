#!/bin/bash

################################################################################
# INSTALL-STARSHIP.SH - Instalación de Starship Prompt
################################################################################
# Descripción:
#   Starship es un prompt minimalista, rápido y altamente personalizable
#   para cualquier shell (Bash, Zsh, Fish, PowerShell, etc.)
#
# Características:
#   - Escrito en Rust (muy rápido)
#   - Muestra información relevante (Git, lenguajes, etc.)
#   - Altamente personalizable
#   - Compatible con Bash y Zsh
#
# Uso:
#   ./install-starship.sh
#
# Requisitos:
#   - curl (para descargar)
#   - Nerd Font (opcional, para iconos)
#
# Documentación: https://starship.rs/
################################################################################

# Obtener el directorio donde está este script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colores para mensajes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Funciones de mensajes
info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

success() {
    echo -e "${GREEN}✅ $1${NC}"
}

warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

error() {
    echo -e "${RED}❌ $1${NC}"
}

################################################################################
# VERIFICACIONES PREVIAS
################################################################################

info "Verificando requisitos previos..."

# Verificar que curl está instalado
if ! command -v curl &> /dev/null; then
    error "curl no está instalado"
    echo "Instalar con: sudo apt install curl"
    exit 1
fi

success "Todos los requisitos están instalados"

################################################################################
# INSTALACIÓN DE STARSHIP
################################################################################

info "Instalando Starship..."

# Descargar e instalar Starship (Instalación manual para evitar errores de detección de plataforma)
STARSHIP_VERSION=$(curl -s https://api.github.com/repos/starship/starship/releases/latest | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/')

if [ -z "$STARSHIP_VERSION" ]; then
    error "No se pudo detectar la versión de Starship"
    exit 1
fi

info "Descargando Starship v$STARSHIP_VERSION..."
if curl -Lo /tmp/starship.tar.gz "https://github.com/starship/starship/releases/download/v${STARSHIP_VERSION}/starship-x86_64-unknown-linux-gnu.tar.gz"; then
    sudo tar -xzf /tmp/starship.tar.gz -C /usr/local/bin
    rm /tmp/starship.tar.gz
    success "Starship instalado correctamente"
else
    error "Error al descargar Starship"
    exit 1
fi

# Verificar instalación
STARSHIP_VERSION=$(starship --version 2>/dev/null | head -n 1)
info "Versión instalada: $STARSHIP_VERSION"

################################################################################
# CONFIGURACIÓN
################################################################################

info "Configurando Starship..."

# Crear directorio de configuración si no existe
mkdir -p ~/.config

# Copiar configuración de DevDeb
# Copiar configuración de DevDeb
ST_CONFIG=""
if [ -f "$SCRIPT_DIR/configs/starship.toml" ]; then
    ST_CONFIG="$SCRIPT_DIR/configs/starship.toml"
elif [ -f "$SCRIPT_DIR/../../configs/starship.toml" ]; then
    ST_CONFIG="$SCRIPT_DIR/../../configs/starship.toml"
fi

if [ -n "$ST_CONFIG" ]; then
    cp "$ST_CONFIG" ~/.config/starship.toml
    success "Configuración de Starship instalada"
else
    warning "No se encontró configuración de Starship en DevDeb"
    warning "Usando configuración predeterminada"
fi

################################################################################
# ACTIVACIÓN EN SHELL
################################################################################

info "Configurando activación en shell..."

# Detectar shell del usuario
USER_SHELL=$(basename "$SHELL")

case "$USER_SHELL" in
    bash)
        # Configurar para Bash
        if ! grep -q "starship init bash" ~/.bashrc 2>/dev/null; then
            echo '' >> ~/.bashrc
            echo '# Starship Prompt' >> ~/.bashrc
            echo 'eval "$(starship init bash)"' >> ~/.bashrc
            success "Starship añadido a ~/.bashrc"
        else
            info "Starship ya está configurado en ~/.bashrc"
        fi
        ;;
    
    zsh)
        # Configurar para Zsh
        if ! grep -q "starship init zsh" ~/.zshrc 2>/dev/null; then
            echo '' >> ~/.zshrc
            echo '# Starship Prompt' >> ~/.zshrc
            echo 'eval "$(starship init zsh)"' >> ~/.zshrc
            success "Starship añadido a ~/.zshrc"
        else
            info "Starship ya está configurado en ~/.zshrc"
        fi
        ;;
    
    *)
        warning "Shell no reconocido: $USER_SHELL"
        warning "Añade manualmente a tu archivo de configuración:"
        echo "  eval \"\$(starship init $USER_SHELL)\""
        ;;
esac

################################################################################
# NERD FONTS (OPCIONAL)
################################################################################

info "Verificando Nerd Fonts..."

if fc-list | grep -qi "nerd"; then
    success "Nerd Font detectada"
else
    warning "No se detectó Nerd Font instalada"
    echo ""
    echo "Para mejor experiencia, instala una Nerd Font:"
    echo "  1. Visita: https://www.nerdfonts.com/"
    echo "  2. Descarga una fuente (recomendado: FiraCode Nerd Font)"
    echo "  3. Instala la fuente en tu sistema"
    echo "  4. Configura tu terminal para usar la fuente"
    echo ""
fi

################################################################################
# FINALIZACIÓN
################################################################################

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
success "¡Starship instalado correctamente!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
info "Próximos pasos:"
echo "  1. Reinicia tu terminal o ejecuta:"
if [ "$USER_SHELL" = "bash" ]; then
    echo "     source ~/.bashrc"
elif [ "$USER_SHELL" = "zsh" ]; then
    echo "     source ~/.zshrc"
fi
echo ""
echo "  2. Verás el nuevo prompt de Starship"
echo ""
info "Personalización:"
echo "  - Configuración: ~/.config/starship.toml"
echo "  - Documentación: https://starship.rs/config/"
echo ""
info "Comandos útiles:"
echo "  starship --version     # Ver versión"
echo "  starship config        # Abrir configuración"
echo "  starship explain       # Explicar elementos del prompt"
echo ""
success "¡Disfruta de tu nuevo prompt! 🚀"
echo ""
