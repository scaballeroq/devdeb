#!/bin/bash

################################################################################
# INSTALL-MODERN-TOOLS.SH - Instalación de Herramientas CLI Modernas
################################################################################
# Descripción:
#   Instala herramientas CLI modernas que mejoran la experiencia de terminal
#
# Herramientas incluidas:
#   - eza: Reemplazo moderno de 'ls' con colores e iconos
#   - bat: Reemplazo de 'cat' con syntax highlighting
#   - fzf: Búsqueda fuzzy interactiva
#   - zoxide: CD inteligente que recuerda directorios frecuentes
#   - ripgrep: Búsqueda de texto ultra rápida
#   - fd: Alternativa simple y rápida a 'find'
#
# Uso:
#   ./install-modern-tools.sh
#
# Requisitos:
#   - Debian 13 Trixie
#   - Permisos de sudo
################################################################################

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
success() { echo -e "${GREEN}✅ $1${NC}"; }
warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
error() { echo -e "${RED}❌ $1${NC}"; }

################################################################################
# ACTUALIZAR REPOSITORIOS
################################################################################

info "Actualizando repositorios..."
sudo apt update

################################################################################
# INSTALAR HERRAMIENTAS
################################################################################

echo ""
info "Instalando herramientas modernas..."
echo ""

# eza (ls mejorado)
info "Instalando eza..."
if command -v eza &> /dev/null; then
    warning "eza ya está instalado"
else
    # eza no está en repos de Debian, instalar desde GitHub releases
    EZA_VERSION=$(curl -s https://api.github.com/repos/eza-community/eza/releases/latest | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/')
    wget -q "https://github.com/eza-community/eza/releases/download/v${EZA_VERSION}/eza_x86_64-unknown-linux-gnu.tar.gz" -O /tmp/eza.tar.gz
    sudo tar -xzf /tmp/eza.tar.gz -C /usr/local/bin
    rm /tmp/eza.tar.gz
    success "eza instalado"
fi

# bat (cat con syntax highlighting)
info "Instalando bat..."
if sudo apt install -y bat; then
    # En Debian, bat se instala como 'batcat' para evitar conflictos
    if [ ! -f /usr/local/bin/bat ] && [ -f /usr/bin/batcat ]; then
        sudo ln -s /usr/bin/batcat /usr/local/bin/bat
    fi
    success "bat instalado"
else
    warning "No se pudo instalar bat"
fi

# fzf (búsqueda fuzzy)
info "Instalando fzf..."
if sudo apt install -y fzf; then
    success "fzf instalado"
else
    warning "No se pudo instalar fzf"
fi

# zoxide (cd inteligente)
info "Instalando zoxide..."
if command -v zoxide &> /dev/null; then
    warning "zoxide ya está instalado"
else
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    success "zoxide instalado"
fi

# ripgrep (grep rápido)
info "Instalando ripgrep..."
if sudo apt install -y ripgrep; then
    success "ripgrep instalado"
else
    warning "No se pudo instalar ripgrep"
fi

# fd (find simple)
info "Instalando fd..."
if sudo apt install -y fd-find; then
    # En Debian, fd se instala como 'fdfind'
    if [ ! -f /usr/local/bin/fd ] && [ -f /usr/bin/fdfind ]; then
        sudo ln -s /usr/bin/fdfind /usr/local/bin/fd
    fi
    success "fd instalado"
else
    warning "No se pudo instalar fd"
fi

################################################################################
# VERIFICACIÓN
################################################################################

echo ""
info "Verificando instalación..."
echo ""

INSTALLED=()
NOT_INSTALLED=()

for tool in eza bat fzf zoxide rg fd; do
    if command -v $tool &> /dev/null; then
        VERSION=$($tool --version 2>/dev/null | head -n 1 || echo "instalado")
        echo "  ✅ $tool: $VERSION"
        INSTALLED+=("$tool")
    else
        echo "  ❌ $tool: no instalado"
        NOT_INSTALLED+=("$tool")
    fi
done

################################################################################
# CONFIGURACIÓN
################################################################################

echo ""
info "Las herramientas están instaladas. Para usarlas:"
echo ""
echo "1. Si usas Zsh, usa la configuración de DevDeb:"
echo "   cp ~/Workspace/Repositorios/Instalación/devdeb/configs/zsh/zshrc ~/.zshrc"
echo "   source ~/.zshrc"
echo ""
echo "2. Si usas Bash, añade a ~/.bashrc:"
echo ""
echo "   # eza"
echo "   alias ls='eza -lh --group-directories-first --icons=auto'"
echo ""
echo "   # bat"
echo "   alias cat='bat --style=auto'"
echo ""
echo "   # fzf"
echo "   alias ff=\"fzf --preview 'bat --style=numbers --color=always {}'\""
echo ""
echo "   # zoxide"
echo "   eval \"\$(zoxide init bash)\""
echo "   alias cd='z'"
echo ""
echo "   # ripgrep"
echo "   alias grep='rg'"
echo ""

################################################################################
# FINALIZACIÓN
################################################################################

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
success "Instalación completada!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
info "Herramientas instaladas: ${#INSTALLED[@]}"
if [ ${#NOT_INSTALLED[@]} -gt 0 ]; then
    warning "No instaladas: ${NOT_INSTALLED[*]}"
fi
echo ""
success "¡Disfruta de tus nuevas herramientas! 🚀"
echo ""
