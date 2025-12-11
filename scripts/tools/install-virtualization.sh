#!/usr/bin/env bash

################################################################################
# INSTALL-VIRTUALIZATION.SH - Instalación de QEMU/KVM/Libvirt
################################################################################
# Descripción:
#   Script automatizado para instalar y configurar QEMU/KVM con libvirt en
#   Debian 13 Trixie. Incluye soporte para UEFI, TPM (Windows 11), drivers
#   VirtIO y configuración completa del entorno de virtualización.
#
# Uso:
#   sudo ./scripts/tools/install-virtualization.sh
#
# Requisitos:
#   - Debian 13 Trixie
#   - CPU con soporte de virtualización (Intel VT-x o AMD-V)
#   - Privilegios sudo
#
# Componentes instalados:
#   - QEMU/KVM (hipervisor)
#   - Libvirt (gestión de VMs)
#   - Virt-Manager (interfaz gráfica)
#   - OVMF (UEFI para VMs)
#   - SWTPM (TPM virtual para Windows 11)
#   - Drivers VirtIO para Windows
#
# Autor: DevDeb
# Fecha: 2025-12-09
# Basado en: https://sysguides.com/install-kvm-on-linux
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

# Verificar que se ejecuta como root o con sudo
if [[ $EUID -ne 0 ]]; then
   print_error "Este script debe ejecutarse con privilegios de root (sudo)"
   exit 1
fi

# Obtener el usuario real (no root)
REAL_USER=${SUDO_USER:-$USER}
REAL_HOME=$(eval echo ~$REAL_USER)

print_header "INSTALACIÓN DE QEMU/KVM/LIBVIRT - DEBIAN 13 TRIXIE"
print_info "Usuario: $REAL_USER"
print_info "Directorio home: $REAL_HOME"
echo ""

################################################################################
# 0. VERIFICACIÓN DE REQUISITOS
################################################################################
print_header "0. VERIFICANDO REQUISITOS DEL SISTEMA"

print_info "Comprobando soporte de virtualización del CPU..."

# Verificar si el CPU soporta virtualización
if grep -E -q '(vmx|svm)' /proc/cpuinfo; then
    CPU_VT=$(grep -E -o '(vmx|svm)' /proc/cpuinfo | head -1)
    if [ "$CPU_VT" = "vmx" ]; then
        print_success "CPU Intel con VT-x detectado"
    else
        print_success "CPU AMD con AMD-V detectado"
    fi
else
    print_error "El CPU no soporta virtualización por hardware"
    print_error "Habilita VT-x/AMD-V en la BIOS/UEFI"
    exit 1
fi

# Verificar si la virtualización está habilitada
if [ -e /dev/kvm ]; then
    print_success "Virtualización habilitada (/dev/kvm existe)"
else
    print_warning "/dev/kvm no existe - puede que necesites habilitar virtualización en BIOS"
fi

# Verificar arquitectura
ARCH=$(uname -m)
if [ "$ARCH" != "x86_64" ]; then
    print_error "Este script solo soporta arquitectura x86_64"
    exit 1
fi
print_success "Arquitectura: $ARCH"

################################################################################
# 1. INSTALACIÓN DE PAQUETES BASE
################################################################################
print_header "1. INSTALANDO PAQUETES BASE"

print_info "Actualizando repositorios..."
apt update -qq

print_info "Instalando QEMU/KVM y herramientas de virtualización..."
# qemu-system-x86: Emulador QEMU para arquitectura x86_64
# libvirt-daemon-system: Demonio de gestión de virtualización
# virtinst: Herramientas de línea de comandos para crear VMs (virt-install)
# virt-manager: Interfaz gráfica para gestionar VMs
# virt-viewer: Visor de consolas de VMs
# ovmf: Firmware UEFI para VMs (necesario para Windows 11 y sistemas modernos)
# swtpm: TPM virtual (Trusted Platform Module - requerido para Windows 11)
# qemu-utils: Utilidades QEMU (qemu-img para gestionar discos virtuales)
# guestfs-tools: Herramientas para acceder y modificar imágenes de disco de VMs
# libosinfo-bin: Base de datos de sistemas operativos (detecta OS automáticamente)
apt install -y \
    qemu-system-x86 \
    libvirt-daemon-system \
    virtinst \
    virt-manager \
    virt-viewer \
    ovmf \
    swtpm \
    qemu-utils \
    guestfs-tools \
    libosinfo-bin

print_success "Paquetes base instalados"

################################################################################
# 2. DESCARGA DE DRIVERS VIRTIO PARA WINDOWS
################################################################################
print_header "2. DESCARGANDO DRIVERS VIRTIO PARA WINDOWS"

print_info "Los drivers VirtIO mejoran drásticamente el rendimiento de VMs Windows"
print_info "Incluyen drivers para: disco, red, gráficos, balón de memoria, etc."
echo ""

# Directorio para drivers
VIRTIO_DIR="$REAL_HOME/Descargas/virtio-drivers"
sudo -u $REAL_USER mkdir -p "$VIRTIO_DIR"

# Versión más reciente de VirtIO
VIRTIO_VERSION="0.1.262"
VIRTIO_URL="https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-${VIRTIO_VERSION}-1/virtio-win-${VIRTIO_VERSION}.iso"

print_step "Descargando VirtIO drivers v${VIRTIO_VERSION}..."
print_info "  Destino: $VIRTIO_DIR"

if sudo -u $REAL_USER wget -q --show-progress "$VIRTIO_URL" -O "$VIRTIO_DIR/virtio-win-${VIRTIO_VERSION}.iso"; then
    print_success "Drivers VirtIO descargados"
    print_info "  Ubicación: $VIRTIO_DIR/virtio-win-${VIRTIO_VERSION}.iso"
    print_info "  Usa esta ISO al instalar Windows en una VM"
else
    print_warning "Error al descargar drivers VirtIO"
    print_info "Puedes descargarlos manualmente desde:"
    print_info "  https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/"
fi

################################################################################
# 3. HABILITAR SERVICIO LIBVIRT
################################################################################
print_header "3. HABILITANDO SERVICIO LIBVIRT"

print_info "Habilitando e iniciando libvirtd..."
# libvirtd: Demonio principal que gestiona las máquinas virtuales
# --now: Inicia el servicio inmediatamente además de habilitarlo
systemctl enable --now libvirtd.service
print_success "Servicio libvirtd habilitado y en ejecución"

# Verificar estado del servicio
if systemctl is-active --quiet libvirtd; then
    print_success "Libvirtd está activo"
else
    print_error "Libvirtd no está activo"
    exit 1
fi

################################################################################
# 4. CONFIGURACIÓN DE RED VIRTUAL
################################################################################
print_header "4. CONFIGURANDO RED VIRTUAL"

print_info "Configurando red virtual 'default'..."
# La red 'default' proporciona NAT para que las VMs accedan a Internet
# Usa el rango 192.168.122.0/24 por defecto

# Iniciar red default si no está activa
if ! virsh net-list --all | grep -q "default.*active"; then
    print_info "  Iniciando red 'default'..."
    virsh net-start default 2>/dev/null || true
fi

# Configurar autostart
print_info "  Configurando inicio automático..."
virsh net-autostart default

# Verificar estado
if virsh net-list | grep -q "default.*active"; then
    print_success "Red virtual 'default' configurada y activa"
else
    print_warning "La red 'default' no está activa"
fi

################################################################################
# 5. CONFIGURACIÓN DE USUARIO
################################################################################
print_header "5. CONFIGURANDO PERMISOS DE USUARIO"

print_info "Añadiendo usuario '$REAL_USER' al grupo 'libvirt'..."
# El grupo libvirt permite gestionar VMs sin sudo
usermod -aG libvirt $REAL_USER
print_success "Usuario añadido al grupo libvirt"

print_warning "IMPORTANTE: Cierra sesión y vuelve a iniciar para que los cambios de grupo surtan efecto"

################################################################################
# 6. CONFIGURACIÓN DE URI DE LIBVIRT
################################################################################
print_header "6. CONFIGURANDO URI DE LIBVIRT"

print_info "Configurando URI por defecto de libvirt..."

# Detectar shell del usuario
USER_SHELL=$(getent passwd $REAL_USER | cut -d: -f7)
SHELL_RC=""

if [[ "$USER_SHELL" == *"zsh"* ]]; then
    SHELL_RC="$REAL_HOME/.zshrc"
    print_info "  Shell detectado: Zsh"
elif [[ "$USER_SHELL" == *"bash"* ]]; then
    SHELL_RC="$REAL_HOME/.bashrc"
    print_info "  Shell detectado: Bash"
else
    print_warning "  Shell no reconocido: $USER_SHELL"
    SHELL_RC="$REAL_HOME/.bashrc"
fi

# Añadir variable de entorno si no existe
if ! grep -q "LIBVIRT_DEFAULT_URI" "$SHELL_RC" 2>/dev/null; then
    echo "" | sudo -u $REAL_USER tee -a "$SHELL_RC" > /dev/null
    echo "# Libvirt URI por defecto" | sudo -u $REAL_USER tee -a "$SHELL_RC" > /dev/null
    echo "export LIBVIRT_DEFAULT_URI='qemu:///system'" | sudo -u $REAL_USER tee -a "$SHELL_RC" > /dev/null
    print_success "Variable LIBVIRT_DEFAULT_URI añadida a $SHELL_RC"
else
    print_info "Variable LIBVIRT_DEFAULT_URI ya existe en $SHELL_RC"
fi

################################################################################
# 7. CONFIGURACIÓN DE PERMISOS EN DIRECTORIO DE IMÁGENES
################################################################################
print_header "7. CONFIGURANDO PERMISOS EN DIRECTORIO DE IMÁGENES"

print_info "Configurando permisos ACL en /var/lib/libvirt/images..."
# ACL (Access Control Lists) permite permisos más granulares que los permisos Unix estándar
# Esto permite que el usuario gestione archivos de disco sin sudo

IMAGES_DIR="/var/lib/libvirt/images"

# Verificar que el directorio existe
if [ ! -d "$IMAGES_DIR" ]; then
    mkdir -p "$IMAGES_DIR"
    print_info "  Directorio creado: $IMAGES_DIR"
fi

# Limpiar ACLs existentes
print_info "  Limpiando ACLs existentes..."
setfacl -R -b "$IMAGES_DIR" 2>/dev/null || true

# Establecer permisos ACL para el usuario
print_info "  Estableciendo permisos para $REAL_USER..."
# -R: Recursivo (aplicar a archivos existentes)
# -m: Modificar ACL
# u:usuario:rwX: Usuario tiene lectura, escritura y ejecución (X solo en directorios)
setfacl -R -m u:$REAL_USER:rwX "$IMAGES_DIR"

# Establecer ACL por defecto para archivos futuros
# d:u:usuario:rwx: ACL por defecto para nuevos archivos
setfacl -m d:u:$REAL_USER:rwx "$IMAGES_DIR"

print_success "Permisos ACL configurados"
print_info "  Usuario '$REAL_USER' tiene acceso completo a $IMAGES_DIR"

################################################################################
# 8. VERIFICACIÓN POST-INSTALACIÓN
################################################################################
print_header "8. VERIFICACIÓN DE INSTALACIÓN"

print_info "Ejecutando virt-host-validate..."
echo ""
# virt-host-validate verifica que el sistema está correctamente configurado para KVM
virt-host-validate qemu || true
echo ""

print_info "Verificando componentes instalados:"
echo ""

# Verificar QEMU
if command -v qemu-system-x86_64 &> /dev/null; then
    QEMU_VERSION=$(qemu-system-x86_64 --version | head -1)
    print_success "QEMU: $QEMU_VERSION"
else
    print_error "QEMU no encontrado"
fi

# Verificar Libvirt
if command -v virsh &> /dev/null; then
    LIBVIRT_VERSION=$(virsh --version)
    print_success "Libvirt: $LIBVIRT_VERSION"
else
    print_error "Libvirt no encontrado"
fi

# Verificar Virt-Manager
if command -v virt-manager &> /dev/null; then
    print_success "Virt-Manager: Instalado"
else
    print_warning "Virt-Manager no encontrado"
fi

# Verificar módulo KVM
if lsmod | grep -q kvm; then
    KVM_MODULE=$(lsmod | grep kvm | head -1 | awk '{print $1}')
    print_success "Módulo KVM: $KVM_MODULE cargado"
else
    print_warning "Módulo KVM no cargado"
fi

echo ""

################################################################################
# 9. RESUMEN FINAL
################################################################################
print_header "INSTALACIÓN COMPLETADA"

echo -e "${GREEN}✓ QEMU/KVM instalado${NC}"
echo -e "${GREEN}✓ Libvirt configurado${NC}"
echo -e "${GREEN}✓ Virt-Manager instalado${NC}"
echo -e "${GREEN}✓ Red virtual configurada${NC}"
echo -e "${GREEN}✓ Usuario añadido al grupo libvirt${NC}"
echo -e "${GREEN}✓ Permisos configurados${NC}"
echo -e "${GREEN}✓ Drivers VirtIO descargados${NC}"
echo ""

print_info "Ubicaciones importantes:"
echo "  • Imágenes de disco: /var/lib/libvirt/images/"
echo "  • Drivers VirtIO: $VIRTIO_DIR/"
echo "  • Configuración libvirt: /etc/libvirt/"
echo ""

print_warning "PRÓXIMOS PASOS:"
echo "  1. REINICIA el sistema o cierra sesión y vuelve a entrar"
echo "     (necesario para que los cambios de grupo surtan efecto)"
echo ""
echo "  2. Verifica la instalación:"
echo "     virt-host-validate qemu"
echo ""
echo "  3. Abre Virt-Manager:"
echo "     virt-manager"
echo "     o busca 'Gestor de máquinas virtuales' en aplicaciones"
echo ""
echo "  4. Para crear una VM desde terminal:"
echo "     virt-install --name=mi-vm --ram=2048 --vcpus=2 \\"
echo "       --disk path=/var/lib/libvirt/images/mi-vm.qcow2,size=20 \\"
echo "       --cdrom=/ruta/a/iso --os-variant=debian11"
echo ""

print_info "Comandos útiles:"
echo "  • Listar VMs: virsh list --all"
echo "  • Iniciar VM: virsh start nombre-vm"
echo "  • Detener VM: virsh shutdown nombre-vm"
echo "  • Eliminar VM: virsh undefine nombre-vm"
echo "  • Ver redes: virsh net-list --all"
echo ""

print_info "Para instalar Windows 11:"
echo "  1. Crea una VM con UEFI (ovmf) y TPM (swtpm)"
echo "  2. Monta la ISO de VirtIO drivers durante la instalación"
echo "  3. Usa los drivers de la carpeta 'w11' en la ISO"
echo ""

print_success "¡Virtualización instalada correctamente! 🚀"
print_warning "Recuerda: REINICIA o cierra sesión para aplicar cambios de grupo"
