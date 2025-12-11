#!/usr/bin/env bash
# DevDeb - Funciones de validación
# Este archivo contiene funciones para validar el sistema y configuraciones

# Cargar utilidades
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

# Validar versión de Debian
validate_debian_version() {
    if [ ! -f /etc/os-release ]; then
        print_error "No se puede determinar la versión del sistema operativo"
        return 1
    fi
    
    source /etc/os-release
    
    if [ "$ID" != "debian" ]; then
        print_error "Este script está diseñado para Debian, detectado: $ID"
        return 1
    fi
    
    local version_major="${VERSION_ID%%.*}"
    if [ "$version_major" -lt 13 ]; then
        print_error "Se requiere Debian 13 (Trixie) o superior, detectado: $VERSION_ID"
        return 1
    fi
    
    print_success "Sistema operativo válido: Debian $VERSION_ID ($VERSION_CODENAME)"
    return 0
}

# Validar arquitectura del sistema
validate_architecture() {
    local arch
    arch=$(uname -m)
    
    if [ "$arch" != "x86_64" ]; then
        print_error "Se requiere arquitectura x86_64, detectado: $arch"
        return 1
    fi
    
    print_success "Arquitectura válida: $arch"
    return 0
}

# Validar conexión a internet
validate_internet() {
    print_step "Verificando conexión a internet..."
    
    if ping -c 1 -W 2 8.8.8.8 >/dev/null 2>&1; then
        print_success "Conexión a internet disponible"
        return 0
    else
        print_error "No hay conexión a internet"
        return 1
    fi
}

# Validar privilegios sudo
validate_sudo() {
    if ! has_sudo && ! is_root; then
        print_error "Se requieren privilegios sudo"
        return 1
    fi
    
    print_success "Privilegios sudo disponibles"
    return 0
}

# Validar entorno GNOME
validate_gnome() {
    if [ "$XDG_CURRENT_DESKTOP" != "GNOME" ]; then
        print_warning "No se detectó GNOME, algunas características pueden no funcionar"
        return 1
    fi
    
    print_success "Entorno GNOME detectado"
    return 0
}

# Validar espacio en disco (en GB)
validate_disk_space() {
    local required_gb="${1:-5}"
    local available_gb
    
    available_gb=$(df -BG / | awk 'NR==2 {print $4}' | sed 's/G//')
    
    if [ "$available_gb" -lt "$required_gb" ]; then
        print_error "Espacio insuficiente en disco. Requerido: ${required_gb}GB, Disponible: ${available_gb}GB"
        return 1
    fi
    
    print_success "Espacio en disco suficiente: ${available_gb}GB disponibles"
    return 0
}

# Validación completa del sistema
validate_system() {
    print_header "Validando sistema..."
    
    local errors=0
    
    validate_debian_version || ((errors++))
    validate_architecture || ((errors++))
    validate_internet || ((errors++))
    validate_sudo || ((errors++))
    validate_disk_space 5 || ((errors++))
    
    if [ $errors -eq 0 ]; then
        print_success "Todas las validaciones pasaron correctamente"
        return 0
    else
        print_error "Falló $errors validación(es)"
        return 1
    fi
}
