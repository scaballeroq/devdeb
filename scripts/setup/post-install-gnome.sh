#!/usr/bin/env bash

################################################################################
# POST-INSTALL-GNOME.SH - Configuración Post-Instalación para Debian 13 Trixie
################################################################################
# Descripción:
#   Script automatizado para configurar un sistema Debian 13 Trixie con GNOME
#   recién instalado. Instala software esencial, codecs, herramientas de
#   desarrollo y configura el aspecto del sistema.
#
# Uso:
#   sudo ./scripts/setup/post-install-gnome.sh
#
# Requisitos:
#   - Debian 13 Trixie con GNOME
#   - Conexión a internet
#   - Privilegios sudo
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

# Verificar que se ejecuta como root o con sudo
if [[ $EUID -ne 0 ]]; then
   print_error "Este script debe ejecutarse con privilegios de root (sudo)"
   exit 1
fi

# Obtener el usuario real (no root)
REAL_USER=${SUDO_USER:-$USER}
REAL_HOME=$(eval echo ~$REAL_USER)

print_header "CONFIGURACIÓN POST-INSTALACIÓN - DEBIAN 13 TRIXIE GNOME"
print_info "Usuario: $REAL_USER"
print_info "Directorio home: $REAL_HOME"
echo ""

################################################################################
# 1. SOFTWARE ESENCIAL
################################################################################
print_header "1. INSTALANDO SOFTWARE ESENCIAL"

print_info "Actualizando repositorios..."
apt update -qq

print_info "Instalando herramientas de desarrollo..."
# linux-headers: Cabeceras del kernel (necesarias para compilar módulos)
# build-essential: Compiladores y herramientas de construcción (gcc, g++, make)
# checkinstall: Crear paquetes .deb desde código fuente
# make, automake, cmake, autoconf: Herramientas de construcción
# curl: Transferencia de datos desde URLs
# btop: Monitor de sistema moderno (mejor que htop)
# htop: Monitor de sistema interactivo
# git: Control de versiones
# inxi: Información del sistema
# gcc: Compilador de C
# libfuse2: Biblioteca para sistemas de archivos en espacio de usuario
apt install -y \
    linux-headers-$(uname -r) \
    build-essential \
    checkinstall \
    make \
    automake \
    cmake \
    autoconf \
    curl \
    btop \
    htop \
    git \
    inxi \
    gcc \
    libfuse2

print_success "Herramientas de desarrollo instaladas"

print_info "Instalando soporte para sistemas de archivos..."
# exfat-fuse: Soporte para sistemas de archivos exFAT (USBs, tarjetas SD)
# hfsplus: Soporte para sistemas de archivos HFS+ (macOS)
apt install -y exfat-fuse hfsplus
print_success "Soporte de sistemas de archivos instalado"

print_info "Instalando aplicaciones multimedia y utilidades..."
# vlc: Reproductor multimedia versátil
# gimp: Editor de imágenes avanzado (alternativa a Photoshop)
# gparted: Editor de particiones gráfico
apt install -y vlc gimp gparted
print_success "Aplicaciones multimedia instaladas"

print_info "Instalando herramientas de compresión..."
# p7zip-full: Soporte completo para archivos 7z
# p7zip-rar: Soporte para archivos RAR en 7zip
# unrar: Descompresor de archivos RAR
# zip/unzip: Compresión/descompresión ZIP
# bzip2: Compresión bzip2
# lzma: Compresión LZMA
apt install -y p7zip-full p7zip-rar unrar zip unzip bzip2 lzma
print_success "Herramientas de compresión instaladas"

################################################################################
# 2. TIENDAS DE SOFTWARE
################################################################################
print_header "2. CONFIGURANDO TIENDAS DE SOFTWARE"

print_info "Instalando Synaptic (gestor de paquetes avanzado)..."
# synaptic: Interfaz gráfica avanzada para APT
apt install -y synaptic
print_success "Synaptic instalado"

print_info "Instalando Flatpak..."
# flatpak: Sistema de paquetes universal para aplicaciones de escritorio
# gnome-software-plugin-flatpak: Integración de Flatpak con GNOME Software
apt install -y flatpak gnome-software-plugin-flatpak
print_success "Flatpak instalado"

print_info "Añadiendo repositorio Flathub..."
# Flathub: Repositorio principal de aplicaciones Flatpak
# --user: Instalar para el usuario actual
# --if-not-exists: Solo añadir si no existe
sudo -u $REAL_USER flatpak remote-add --user --if-not-exists flathub \
    https://dl.flathub.org/repo/flathub.flatpakrepo
print_success "Flathub configurado"

################################################################################
# 3. CODECS MULTIMEDIA
################################################################################
print_header "3. INSTALANDO CODECS MULTIMEDIA"

print_info "Instalando codecs de audio y video..."
# gstreamer1.0-pulseaudio: Soporte PulseAudio para GStreamer
# gstreamer1.0-plugins-bad: Plugins de calidad variable (formatos menos comunes)
# gstreamer1.0-plugins-ugly: Plugins con posibles problemas de licencia
# gstreamer1.0-libav: Wrapper de libav/ffmpeg para GStreamer
# libavcodec-extra: Codecs adicionales de libav
# vorbis-tools: Herramientas para archivos Ogg Vorbis
# ffmpeg: Suite completa de conversión multimedia
# ffmpeg-doc: Documentación de ffmpeg
apt install -y \
    gstreamer1.0-pulseaudio \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav \
    libavcodec-extra \
    vorbis-tools \
    ffmpeg \
    ffmpeg-doc

print_success "Codecs multimedia instalados"

################################################################################
# 4. ASPECTO Y TEMAS
################################################################################
print_header "4. CONFIGURANDO ASPECTO DEL SISTEMA"

print_info "Instalando tema de iconos Papirus..."
# papirus-icon-theme: Conjunto de iconos moderno y colorido
apt install -y papirus-icon-theme
print_success "Tema Papirus instalado"

print_info "Aplicando tema de iconos..."
# Configurar Papirus como tema de iconos predeterminado
sudo -u $REAL_USER dbus-launch gsettings set org.gnome.desktop.interface icon-theme 'Papirus' 2>/dev/null || true
print_success "Tema de iconos aplicado"

################################################################################
# 5. INFORMACIÓN DEL SISTEMA
################################################################################
print_header "5. INFORMACIÓN DEL SISTEMA"

print_info "Verificando configuración de audio (PipeWire)..."
# inxi -Aa: Muestra información detallada de audio
echo ""
inxi -Aa
echo ""
print_success "Información de audio mostrada"

print_info "Verificando aceleración gráfica (Mesa)..."
# glxinfo: Información de OpenGL
# Verifica que la aceleración por hardware esté funcionando
if command -v glxinfo &> /dev/null; then
    echo ""
    glxinfo | grep "OpenGL version"
    echo ""
    print_success "Aceleración gráfica verificada"
else
    print_warning "glxinfo no está instalado. Instalando mesa-utils..."
    apt install -y mesa-utils
    echo ""
    glxinfo | grep "OpenGL version"
    echo ""
    print_success "Aceleración gráfica verificada"
fi

################################################################################
# 7. PERSONALIZACIÓN DE GNOME
################################################################################
print_header "7. PERSONALIZACIÓN DE GNOME"

print_info "Instalando GNOME Tweaks..."
# gnome-tweaks: Herramienta de personalización avanzada para GNOME
# Permite cambiar temas, fuentes, comportamiento de ventanas, etc.
apt install -y gnome-tweaks
print_success "GNOME Tweaks instalado"

print_info "Instalando gestor de extensiones de GNOME..."
# gnome-shell-extension-manager: Gestor gráfico de extensiones
# Facilita instalar, activar y configurar extensiones de GNOME Shell
apt install -y gnome-shell-extension-manager
print_success "Gestor de extensiones instalado"

print_info "Instalando extensiones básicas de GNOME..."
# gnome-shell-extensions: Conjunto de extensiones oficiales
# Incluye: Applications Menu, Window List, Places Status Indicator, etc.
apt install -y gnome-shell-extensions
print_success "Extensiones básicas instaladas"

print_info "Instalando extensiones adicionales desde extensions.gnome.org..."
# Instalar herramienta para descargar extensiones
apt install -y gnome-shell-extension-prefs wget unzip

# Lista de extensiones a instalar (UUID de extensions.gnome.org)
declare -A EXTENSIONS=(
    ["BingWallpaper@ineffable-gmail.com"]="https://extensions.gnome.org/extension/1262/bing-wallpaper-changer/"
    ["dash-to-dock@micxgx.gmail.com"]="https://extensions.gnome.org/extension/307/dash-to-dock/"
    ["lockkeys@vaina.lt"]="https://extensions.gnome.org/extension/36/lock-keys/"
    ["status-area-horizontal-spacing@mathematical.coffee.gmail.com"]="https://extensions.gnome.org/extension/355/status-area-horizontal-spacing/"
    ["caffeine@patapon.info"]="https://extensions.gnome.org/extension/517/caffeine/"
    ["quick-settings-audio-panel@rayzeq.github.io"]="https://extensions.gnome.org/extension/5940/quick-settings-audio-panel/"
    ["clipboard-indicator@tudmotu.com"]="https://extensions.gnome.org/extension/779/clipboard-indicator/"
    ["blur-my-shell@aunetx"]="https://extensions.gnome.org/extension/3193/blur-my-shell/"
    ["tilingshell@ferrarodomenico.com"]="https://extensions.gnome.org/extension/7065/tiling-shell/"
    ["appindicatorsupport@rgcjonas.gmail.com"]="https://extensions.gnome.org/extension/615/appindicator-support/"
)

# Función para instalar extensión desde extensions.gnome.org
install_gnome_extension() {
    local uuid="$1"
    local extension_id=$(echo "$2" | grep -oP 'extension/\K[0-9]+')
    
    print_info "  Instalando: $uuid"
    
    # Obtener información de la extensión
    local info_url="https://extensions.gnome.org/extension-info/?pk=${extension_id}&shell_version=$(gnome-shell --version | cut -d' ' -f3 | cut -d'.' -f1,2)"
    local download_url=$(curl -s "$info_url" | grep -oP '"download_url":\s*"\K[^"]+' | head -1)
    
    if [ -z "$download_url" ]; then
        print_warning "    No se pudo obtener URL de descarga para $uuid"
        return 1
    fi
    
    # Descargar extensión
    local temp_file="/tmp/${uuid}.zip"
    wget -q "https://extensions.gnome.org${download_url}" -O "$temp_file" 2>/dev/null || {
        print_warning "    Error al descargar $uuid"
        return 1
    }
    
    # Crear directorio de extensión
    local ext_dir="$REAL_HOME/.local/share/gnome-shell/extensions/${uuid}"
    sudo -u $REAL_USER mkdir -p "$ext_dir"
    
    # Extraer extensión
    sudo -u $REAL_USER unzip -q -o "$temp_file" -d "$ext_dir"
    rm "$temp_file"
    
    # Habilitar extensión
    sudo -u $REAL_USER gnome-extensions enable "$uuid" 2>/dev/null || true
    
    print_success "    ✓ $uuid instalada"
}

# Instalar cada extensión
for uuid in "${!EXTENSIONS[@]}"; do
    install_gnome_extension "$uuid" "${EXTENSIONS[$uuid]}"
done

print_success "Extensiones adicionales instaladas"

print_info "Extensiones instaladas:"
echo "  • Bing Wallpaper Changer - Fondos de pantalla de Bing diarios"
echo "  • Dash to Dock - Dock personalizable en cualquier borde"
echo "  • Lock Keys - Indicador de Bloq Mayús/Num"
echo "  • Status Area Horizontal Spacing - Ajustar espaciado del panel"
echo "  • Caffeine - Prevenir suspensión automática"
echo "  • Quick Settings Audio Panel - Panel de audio mejorado"
echo "  • Clipboard Indicator - Gestor de portapapeles"
echo "  • Blur My Shell - Efectos de desenfoque"
echo "  • Tiling Shell - Gestor de ventanas en mosaico"
echo "  • AppIndicator Support - Soporte para iconos de bandeja"
echo ""
print_warning "IMPORTANTE: Reinicia GNOME Shell (Alt+F2, escribe 'r', Enter) o reinicia el sistema"
print_info "Usa 'Extensiones' para configurar cada extensión"
print_success "Personalización de GNOME configurada"

################################################################################
# 8. SEGURIDAD BÁSICA
################################################################################
print_header "8. CONFIGURANDO SEGURIDAD BÁSICA"

print_info "Instalando UFW (Uncomplicated Firewall)..."
# ufw: Firewall simple y fácil de usar
# Interfaz simplificada para iptables
apt install -y ufw
print_success "UFW instalado"

print_info "Instalando interfaz gráfica para UFW..."
# gufw: Interfaz gráfica para UFW
# Permite gestionar el firewall desde el entorno gráfico
apt install -y gufw
print_success "GUFW instalado"

print_info "Configurando reglas básicas del firewall..."
# Configuración básica de UFW

# Denegar todas las conexiones entrantes por defecto
ufw default deny incoming
print_info "  ✓ Conexiones entrantes: DENEGADAS por defecto"

# Permitir todas las conexiones salientes por defecto
ufw default allow outgoing
print_info "  ✓ Conexiones salientes: PERMITIDAS por defecto"

# Permitir SSH (puerto 22) si está instalado
if systemctl is-active --quiet ssh || systemctl is-active --quiet sshd; then
    ufw allow ssh
    print_info "  ✓ SSH (puerto 22): PERMITIDO"
fi

# Habilitar UFW
print_info "Habilitando firewall..."
echo "y" | ufw enable
print_success "Firewall UFW activado y configurado"

print_info "Estado del firewall:"
ufw status verbose
echo ""

print_warning "IMPORTANTE: El firewall está activo con reglas básicas"
print_info "Para gestionar el firewall:"
echo "  • Interfaz gráfica: Busca 'Firewall' en aplicaciones"
echo "  • Terminal: sudo ufw status"
echo "  • Permitir puerto: sudo ufw allow <puerto>"
echo "  • Denegar puerto: sudo ufw deny <puerto>"
echo ""

################################################################################
# 9. LIMPIEZA Y OPTIMIZACIÓN
################################################################################
print_header "9. LIMPIEZA Y OPTIMIZACIÓN"

print_info "Limpiando paquetes innecesarios..."
apt autoremove -y
apt autoclean
print_success "Sistema limpiado"

################################################################################
# 10. RESUMEN FINAL
################################################################################
print_header "INSTALACIÓN COMPLETADA"

echo -e "${GREEN}✓ Software esencial instalado${NC}"
echo -e "${GREEN}✓ Tiendas de software configuradas (Synaptic, Flatpak)${NC}"
echo -e "${GREEN}✓ Codecs multimedia instalados${NC}"
echo -e "${GREEN}✓ Tema de iconos Papirus aplicado${NC}"
echo -e "${GREEN}✓ GNOME personalizado (Tweaks + Extensiones)${NC}"
echo -e "${GREEN}✓ Firewall UFW activado y configurado${NC}"
echo -e "${GREEN}✓ Sistema verificado y optimizado${NC}"
echo ""

print_info "Paquetes instalados:"
echo "  • Desarrollo: build-essential, git, cmake, gcc"
echo "  • Monitoreo: btop, htop, inxi"
echo "  • Multimedia: vlc, gimp, ffmpeg"
echo "  • Utilidades: gparted, p7zip, unrar"
echo "  • Sistemas de archivos: exfat-fuse, hfsplus"
echo "  • Gestores: synaptic, flatpak"
echo "  • Temas: papirus-icon-theme"
echo "  • Personalización: gnome-tweaks, extension-manager, gnome-shell-extensions"
echo "  • Seguridad: ufw, gufw"
echo ""

print_warning "RECOMENDACIONES:"
echo "  1. Reinicia el sistema para aplicar todos los cambios"
echo "  2. Abre GNOME Software para explorar aplicaciones Flatpak"
echo "  3. Usa 'btop' para monitorear el sistema"
echo "  4. Abre 'Ajustes' (GNOME Tweaks) para personalizar GNOME"
echo "  5. Abre 'Extensiones' para activar extensiones de GNOME Shell"
echo "  6. Abre 'Firewall' para gestionar reglas del firewall"
echo ""

print_info "Para más configuraciones, consulta los scripts en:"
echo "  • scripts/tools/ - Herramientas de desarrollo"
echo "  • scripts/apps/ - Aplicaciones adicionales"
echo "  • docs/guides/ - Guías de uso"
echo ""

print_success "¡Configuración completada exitosamente!"
