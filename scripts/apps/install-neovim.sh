#!/bin/bash

################################################################################
# INSTALL-NEOVIM.SH - Instalación Independiente de Neovim + LazyVim
################################################################################
# Descripción:
#   Este script instala Neovim y lo configura con LazyVim, una distribución
#   moderna de Neovim con plugins preconfigurados. Es completamente independiente
#   y no requiere tener DevDeb instalado.
#
# Componentes instalados:
#   - Neovim stable (última versión)
#   - LazyVim (distribución de Neovim)
#   - luarocks (gestor de paquetes Lua)
#   - tree-sitter-cli (parser para resaltado de sintaxis)
#
# Configuraciones aplicadas:
#   1. Tema Tokyo Night por defecto
#   2. Transparencia del terminal
#   3. Desactivación de scroll animado
#   4. Desactivación de números de línea relativos
#   5. Neo-tree como explorador de archivos por defecto
#   6. Lanzador de escritorio (opcional, requiere Alacritty)
#
# Uso:
#   ./install-neovim.sh
#
# Requisitos:
#   - wget, tar (para descargar e instalar Neovim)
#   - git (para clonar LazyVim)
#   - Alacritty (opcional, para lanzador de escritorio)
#
# Notas:
#   - Si ya tienes configuración de Neovim, se respetará
#   - Los archivos de configuración están en devdeb/configs/neovim/
#   - Al primer inicio, LazyVim descargará todos los plugins automáticamente
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

# Verificar que wget está instalado
if ! command -v wget &> /dev/null; then
    error "wget no está instalado"
    echo "Instalar con: sudo apt install wget"
    exit 1
fi

# Verificar que tar está instalado
if ! command -v tar &> /dev/null; then
    error "tar no está instalado"
    echo "Instalar con: sudo apt install tar"
    exit 1
fi

# Verificar que git está instalado
if ! command -v git &> /dev/null; then
    error "git no está instalado"
    echo "Instalar con: sudo apt install git"
    exit 1
fi

success "Todos los requisitos están instalados"

################################################################################
# INSTALACIÓN DE NEOVIM
################################################################################

info "Instalando Neovim..."

# Cambiar al directorio temporal
cd /tmp

# Descargar la última versión estable de Neovim para Linux x86_64
info "Descargando Neovim stable..."
if ! wget -q --show-progress -O nvim.tar.gz "https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz"; then
    error "No se pudo descargar Neovim"
    exit 1
fi

# Extraer el archivo comprimido
info "Extrayendo archivos..."
tar -xf nvim.tar.gz

# Instalar el binario de Neovim en /usr/local/bin
info "Instalando Neovim en el sistema..."
sudo install nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim

# Copiar las librerías necesarias
sudo cp -R nvim-linux-x86_64/lib /usr/local/

# Copiar archivos compartidos (runtime, documentación, etc.)
sudo cp -R nvim-linux-x86_64/share /usr/local/

# Limpiar archivos temporales
rm -rf nvim-linux-x86_64 nvim.tar.gz

# Volver al directorio anterior
cd - > /dev/null

success "Neovim instalado correctamente"

# Verificar instalación
NVIM_VERSION=$(nvim --version | head -n 1)
info "Versión instalada: $NVIM_VERSION"

################################################################################
# INSTALACIÓN DE DEPENDENCIAS
################################################################################

info "Instalando dependencias de LazyVim..."

# Instalar luarocks y tree-sitter-cli
# Estos resuelven advertencias de :checkhealth en LazyVim
sudo apt install -y luarocks tree-sitter-cli

success "Dependencias instaladas"

################################################################################
# CONFIGURACIÓN DE LAZYVIM
################################################################################

# Solo configurar si Neovim nunca ha sido ejecutado
# Esto evita sobrescribir configuraciones existentes del usuario
if [ ! -d "$HOME/.config/nvim" ]; then
    info "Configurando LazyVim (primera instalación)..."
    
    # Clonar el starter de LazyVim
    # LazyVim es una distribución de Neovim con plugins y configuraciones preestablecidas
    info "Clonando LazyVim starter..."
    if ! git clone https://github.com/LazyVim/starter ~/.config/nvim; then
        error "No se pudo clonar LazyVim"
        exit 1
    fi
    
    # Eliminar el directorio .git para que el usuario pueda añadirlo a su propio repo
    rm -rf ~/.config/nvim/.git
    
    success "LazyVim clonado correctamente"
    
    ############################################################################
    # APLICAR CONFIGURACIONES PERSONALIZADAS
    ############################################################################
    
    info "Aplicando configuraciones personalizadas..."
    
    # 1. Configurar transparencia para que coincida con el terminal
    mkdir -p ~/.config/nvim/plugin/after
    cp "$SCRIPT_DIR/configs/neovim/transparency.lua" ~/.config/nvim/plugin/after/
    success "Transparencia configurada"
    
    # 2. Establecer Tokyo Night como tema por defecto
    cp "$SCRIPT_DIR/configs/neovim/theme-tokyonight.lua" ~/.config/nvim/lua/plugins/theme.lua
    success "Tema Tokyo Night configurado"
    
    # 3. Desactivar el scroll animado
    cp "$SCRIPT_DIR/configs/neovim/snacks-animated-scrolling-off.lua" ~/.config/nvim/lua/plugins/
    success "Scroll animado desactivado"
    
    # 4. Desactivar números de línea relativos
    echo "vim.opt.relativenumber = false" >> ~/.config/nvim/lua/config/options.lua
    success "Números de línea relativos desactivados"
    
    # 5. Asegurar que neo-tree (explorador de archivos) se use por defecto
    cp "$SCRIPT_DIR/configs/neovim/lazyvim.json" ~/.config/nvim/
    success "Neo-tree configurado como explorador por defecto"
    
    success "Todas las configuraciones aplicadas"
    
else
    warning "Ya existe una configuración de Neovim en ~/.config/nvim"
    warning "No se sobrescribirá. Si quieres reinstalar, elimina primero:"
    warning "  rm -rf ~/.config/nvim"
    warning "  Luego ejecuta este script de nuevo"
fi

################################################################################
# LANZADOR DE ESCRITORIO (OPCIONAL)
################################################################################

# Crear lanzador de escritorio si el directorio de aplicaciones existe
if [[ -d ~/.local/share/applications ]]; then
    info "Creando lanzador de escritorio..."
    
    # Verificar si Alacritty está instalado
    if command -v alacritty &> /dev/null; then
        # Crear lanzador que abre Neovim en Alacritty
        cat <<EOF > ~/.local/share/applications/Neovim.desktop
[Desktop Entry]
Version=1.0
Name=Neovim
Comment=Edit text files
Exec=alacritty --class=Neovim --title=Neovim -e nvim %F
Terminal=false
Type=Application
Icon=nvim
Categories=Utilities;TextEditor;
StartupNotify=false
EOF
        
        chmod +x ~/.local/share/applications/Neovim.desktop
        success "Lanzador de escritorio creado (abre en Alacritty)"
    else
        # Crear lanzador genérico que abre en terminal predeterminado
        cat <<EOF > ~/.local/share/applications/Neovim.desktop
[Desktop Entry]
Version=1.0
Name=Neovim
Comment=Edit text files
Exec=x-terminal-emulator -e nvim %F
Terminal=false
Type=Application
Icon=nvim
Categories=Utilities;TextEditor;
StartupNotify=false
EOF
        
        chmod +x ~/.local/share/applications/Neovim.desktop
        success "Lanzador de escritorio creado (abre en terminal predeterminado)"
        info "Para mejor experiencia, instala Alacritty: sudo apt install alacritty"
    fi
    
    # Eliminar lanzadores del sistema si existen (evitar duplicados)
    sudo rm -f /usr/share/applications/nvim.desktop
    sudo rm -f /usr/local/share/applications/nvim.desktop
fi

################################################################################
# FINALIZACIÓN
################################################################################

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
success "¡Neovim + LazyVim instalado correctamente!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
info "Configuración aplicada:"
echo "  ✓ Tema: Tokyo Night"
echo "  ✓ Transparencia: Activada"
echo "  ✓ Scroll animado: Desactivado"
echo "  ✓ Números relativos: Desactivados"
echo "  ✓ Explorador: Neo-tree"
echo ""
info "Próximos pasos:"
echo "  1. Ejecuta 'nvim' para iniciar Neovim"
echo "  2. En el primer inicio, LazyVim descargará todos los plugins"
echo "     (esto puede tomar unos minutos)"
echo "  3. Espera a que termine la instalación de plugins"
echo "  4. Reinicia Neovim cuando termine"
echo ""
info "Comandos útiles en Neovim:"
echo "  <leader>e  - Abrir/cerrar Neo-tree (explorador de archivos)"
echo "  <leader>ff - Buscar archivos (Telescope)"
echo "  <leader>sg - Buscar en archivos (grep)"
echo "  :checkhealth - Verificar estado de Neovim"
echo "  :Lazy - Gestionar plugins"
echo ""
info "Documentación:"
echo "  LazyVim: https://www.lazyvim.org/"
echo "  Neovim: https://neovim.io/"
echo ""
success "¡Disfruta de Neovim! 🚀"
echo ""
