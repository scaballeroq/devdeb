#!/usr/bin/env bash
# DevDeb - Funciones de utilidad comunes
# Este archivo contiene funciones reutilizables para scripts

# Cargar colores
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/colors.sh"

# Verificar si un comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Verificar si el script se ejecuta con privilegios de root
is_root() {
    [ "$(id -u)" -eq 0 ]
}

# Verificar si el usuario tiene acceso sudo
has_sudo() {
    sudo -n true 2>/dev/null
}

# Crear backup de un archivo
backup_file() {
    local file="$1"
    if [ -f "$file" ]; then
        local backup="${file}.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$file" "$backup"
        print_success "Backup creado: $backup"
        return 0
    else
        print_warning "Archivo no existe: $file"
        return 1
    fi
}

# Verificar dependencias
check_dependencies() {
    local missing_deps=()
    for cmd in "$@"; do
        if ! command_exists "$cmd"; then
            missing_deps+=("$cmd")
        fi
    done
    
    if [ ${#missing_deps[@]} -gt 0 ]; then
        print_error "Dependencias faltantes: ${missing_deps[*]}"
        return 1
    fi
    return 0
}

# Instalar paquetes con apt
install_packages() {
    print_step "Instalando paquetes: $*"
    sudo apt-get update -qq
    sudo apt-get install -y "$@"
}

# Descargar archivo con verificación
download_file() {
    local url="$1"
    local output="$2"
    
    if command_exists wget; then
        wget -q --show-progress -O "$output" "$url"
    elif command_exists curl; then
        curl -fsSL -o "$output" "$url"
    else
        print_error "wget o curl no están instalados"
        return 1
    fi
}

# Preguntar confirmación al usuario
confirm() {
    local prompt="${1:-¿Continuar?}"
    local response
    
    read -r -p "$prompt [s/N] " response
    case "$response" in
        [sS][iI]|[sS])
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Obtener directorio del proyecto DevDeb
get_devdeb_dir() {
    # Asume que este script está en lib/
    echo "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
}

# Logging con timestamp
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

# Manejo de errores
error_exit() {
    print_error "$1"
    exit "${2:-1}"
}
