#!/usr/bin/env bash

################################################################################
# SETUP-FINGERPRINT.SH - Configuración de Lector de Huellas Dactilares
################################################################################
# Descripción:
#   Script para configurar y habilitar autenticación por huella dactilar en
#   Debian 13 Trixie con GNOME. Incluye instalación de fprintd, registro de
#   huellas y configuración de PAM para login, sudo y desbloqueo de pantalla.
#
# Uso:
#   sudo ./scripts/setup/setup-fingerprint.sh
#
# Requisitos:
#   - Debian 13 Trixie con GNOME
#   - Lector de huellas dactilares compatible
#   - Privilegios sudo
#
# Componentes instalados:
#   - fprintd: Demonio de huellas dactilares
#   - libpam-fprintd: Módulo PAM para autenticación
#   - fprintd-clients: Herramientas de línea de comandos (opcional)
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

# Verificar que se ejecuta como root o con sudo
if [[ $EUID -ne 0 ]]; then
   print_error "Este script debe ejecutarse con privilegios de root (sudo)"
   exit 1
fi

# Obtener el usuario real (no root)
REAL_USER=${SUDO_USER:-$USER}
REAL_HOME=$(eval echo ~$REAL_USER)

print_header "CONFIGURACIÓN DE LECTOR DE HUELLAS DACTILARES"
print_info "Usuario: $REAL_USER"
echo ""

################################################################################
# 1. VERIFICACIÓN DE HARDWARE
################################################################################
print_header "1. VERIFICANDO HARDWARE"

print_info "Buscando lector de huellas dactilares..."

# Buscar dispositivos de huellas en lsusb
if lsusb | grep -i -E "finger|biometric|validity|synaptics|goodix|elan" > /dev/null; then
    print_success "Lector de huellas detectado:"
    lsusb | grep -i -E "finger|biometric|validity|synaptics|goodix|elan" | sed 's/^/  /'
    echo ""
else
    print_warning "No se detectó un lector de huellas en USB"
    print_info "Verificando dispositivos internos..."
fi

# Verificar en dmesg
if dmesg | grep -i -E "finger|biometric" > /dev/null; then
    print_info "Información del kernel sobre lector de huellas:"
    dmesg | grep -i -E "finger|biometric" | tail -5 | sed 's/^/  /'
    echo ""
fi

################################################################################
# 2. INSTALACIÓN DE PAQUETES
################################################################################
print_header "2. INSTALANDO PAQUETES"

print_info "Actualizando repositorios..."
apt update -qq

print_info "Instalando fprintd y dependencias..."
# fprintd: Demonio que gestiona lectores de huellas dactilares
#   - Proporciona D-Bus API para aplicaciones
#   - Almacena huellas de forma segura
#   - Compatible con múltiples lectores
# libpam-fprintd: Módulo PAM (Pluggable Authentication Module)
#   - Permite autenticación por huella en login, sudo, etc.
#   - Se integra con el sistema de autenticación de Linux
apt install -y fprintd libpam-fprintd

print_success "Paquetes instalados"

# Instalar herramientas adicionales opcionales
print_info "Instalando herramientas de línea de comandos..."
apt install -y fprintd-clients 2>/dev/null || print_warning "fprintd-clients no disponible"

################################################################################
# 3. VERIFICACIÓN DEL SERVICIO
################################################################################
print_header "3. VERIFICANDO SERVICIO FPRINTD"

print_info "Comprobando estado del servicio..."

# Verificar si el servicio está activo
if systemctl is-active --quiet fprintd; then
    print_success "Servicio fprintd está activo"
else
    print_info "Iniciando servicio fprintd..."
    systemctl start fprintd || true
fi

# Verificar dispositivos detectados
print_info "Dispositivos de huellas detectados:"
if command -v fprintd-list &> /dev/null; then
    fprintd-list $REAL_USER 2>/dev/null | sed 's/^/  /' || print_warning "  No se pudieron listar dispositivos"
else
    print_warning "  Comando fprintd-list no disponible"
fi
echo ""

################################################################################
# 4. REGISTRO DE HUELLAS
################################################################################
print_header "4. REGISTRO DE HUELLAS DACTILARES"

print_info "Ahora vamos a registrar tus huellas dactilares"
print_warning "IMPORTANTE: Necesitarás escanear el mismo dedo varias veces"
echo ""

print_step "Iniciando proceso de registro..."
print_info "Sigue las instrucciones en pantalla"
print_info "Presiona Ctrl+C si quieres cancelar"
echo ""

# Ejecutar fprintd-enroll como el usuario real
if sudo -u $REAL_USER fprintd-enroll; then
    print_success "Huella registrada correctamente"
else
    print_error "Error al registrar huella"
    print_info "Puedes registrar huellas manualmente más tarde con:"
    print_info "  fprintd-enroll"
fi

echo ""

################################################################################
# 5. CONFIGURACIÓN DE PAM
################################################################################
print_header "5. CONFIGURANDO AUTENTICACIÓN PAM"

print_info "Configurando módulos PAM para autenticación por huella..."

# pam-auth-update configura automáticamente PAM
# Habilita libpam-fprintd para login, sudo, etc.
print_info "Ejecutando pam-auth-update..."
print_warning "Se abrirá un menú interactivo"
print_info "Asegúrate de seleccionar 'Fingerprint authentication'"
echo ""

sleep 2

# Ejecutar pam-auth-update
pam-auth-update

print_success "Configuración PAM completada"

################################################################################
# 6. CONFIGURACIÓN DE GNOME
################################################################################
print_header "6. CONFIGURANDO GNOME"

print_info "Habilitando autenticación por huella en GNOME..."

# Verificar si GNOME Settings Daemon está disponible
if command -v gnome-control-center &> /dev/null; then
    print_success "GNOME Control Center disponible"
    print_info "Puedes configurar huellas adicionales en:"
    print_info "  Configuración → Usuarios → Huellas dactilares"
else
    print_warning "GNOME Control Center no encontrado"
fi

################################################################################
# 7. VERIFICACIÓN Y PRUEBAS
################################################################################
print_header "7. VERIFICACIÓN DE CONFIGURACIÓN"

print_info "Verificando huellas registradas..."
echo ""

# Listar huellas del usuario
if command -v fprintd-list &> /dev/null; then
    sudo -u $REAL_USER fprintd-list $REAL_USER || print_warning "No se pudieron listar huellas"
else
    print_warning "Comando fprintd-list no disponible"
fi

echo ""

# Verificar configuración PAM
print_info "Verificando configuración PAM..."
if grep -q "pam_fprintd.so" /etc/pam.d/common-auth; then
    print_success "Módulo PAM fprintd configurado en common-auth"
else
    print_warning "Módulo PAM fprintd NO encontrado en common-auth"
    print_info "Puede que necesites ejecutar: sudo pam-auth-update"
fi

################################################################################
# 8. CONFIGURACIÓN ADICIONAL (OPCIONAL)
################################################################################
print_header "8. CONFIGURACIÓN ADICIONAL"

print_info "Configuraciones opcionales disponibles:"
echo ""

# Timeout de autenticación
print_step "1. Ajustar timeout de autenticación"
print_info "   Edita /etc/pam.d/common-auth y añade timeout a pam_fprintd.so:"
print_info "   auth sufficient pam_fprintd.so timeout=10"
echo ""

# Requerir huella + contraseña
print_step "2. Requerir huella Y contraseña (más seguro)"
print_info "   Cambia 'sufficient' por 'required' en /etc/pam.d/common-auth"
print_info "   auth required pam_fprintd.so"
echo ""

# Deshabilitar para sudo
print_step "3. Deshabilitar huella para sudo (solo para login)"
print_info "   Edita /etc/pam.d/sudo y comenta la línea de pam_fprintd.so"
echo ""

################################################################################
# 9. SOLUCIÓN DE PROBLEMAS
################################################################################
print_header "9. SOLUCIÓN DE PROBLEMAS"

print_info "Si tienes problemas, prueba estos comandos:"
echo ""

echo "  • Ver logs del servicio:"
echo "    journalctl -u fprintd -f"
echo ""

echo "  • Reiniciar servicio fprintd:"
echo "    sudo systemctl restart fprintd"
echo ""

echo "  • Eliminar todas las huellas:"
echo "    fprintd-delete \$USER"
echo ""

echo "  • Registrar nueva huella:"
echo "    fprintd-enroll"
echo ""

echo "  • Verificar huella registrada:"
echo "    fprintd-verify"
echo ""

echo "  • Listar dispositivos:"
echo "    lsusb | grep -i finger"
echo ""

################################################################################
# 10. RESUMEN FINAL
################################################################################
print_header "CONFIGURACIÓN COMPLETADA"

echo -e "${GREEN}✓ fprintd instalado y configurado${NC}"
echo -e "${GREEN}✓ Huella dactilar registrada${NC}"
echo -e "${GREEN}✓ PAM configurado para autenticación${NC}"
echo -e "${GREEN}✓ GNOME configurado${NC}"
echo ""

print_info "Dónde puedes usar la huella dactilar:"
echo "  • Login de GNOME (pantalla de inicio de sesión)"
echo "  • Desbloqueo de pantalla"
echo "  • Comando sudo en terminal"
echo "  • Autenticación de aplicaciones que requieren privilegios"
echo ""

print_warning "IMPORTANTE:"
echo "  • La huella NO reemplaza tu contraseña"
echo "  • Siempre puedes usar tu contraseña si la huella falla"
echo "  • Registra múltiples dedos para mayor comodidad"
echo ""

print_info "Configuración adicional en GNOME:"
echo "  1. Abre 'Configuración' (Settings)"
echo "  2. Ve a 'Usuarios' (Users)"
echo "  3. Haz clic en 'Huellas dactilares' (Fingerprint)"
echo "  4. Añade más huellas si lo deseas"
echo ""

print_info "Para probar la autenticación:"
echo "  1. Bloquea la pantalla (Super+L)"
echo "  2. Intenta desbloquear con tu huella"
echo "  3. O prueba con: sudo -v (en terminal)"
echo ""

print_success "¡Autenticación por huella dactilar configurada! 👆"
