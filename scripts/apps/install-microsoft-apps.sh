#!/usr/bin/env bash

################################################################################
# INSTALL-MICROSOFT-APPS.SH - Instalación de Aplicaciones de Microsoft
################################################################################
# Descripción:
#   Script para instalar aplicaciones de Microsoft en Debian 13 Trixie.
#   Configura el repositorio oficial de Microsoft y permite instalar:
#   - Microsoft Edge (navegador)
#   - Visual Studio Code (editor de código)
#
# Uso:
#   sudo ./scripts/apps/install-microsoft-apps.sh
#
# Requisitos:
#   - Debian 13 Trixie
#   - Conexión a internet
#   - Privilegios sudo
#
# Componentes:
#   - Repositorio de Microsoft
#   - Clave GPG de Microsoft
#   - Microsoft Edge (opcional)
#   - Visual Studio Code (opcional)
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

print_header "INSTALACIÓN DE APLICACIONES DE MICROSOFT"

################################################################################
# 1. INSTALACIÓN DE DEPENDENCIAS
################################################################################
print_header "1. INSTALANDO DEPENDENCIAS"

print_info "Actualizando repositorios..."
apt update -qq

print_info "Instalando herramientas necesarias..."
# curl: Para descargar archivos
# gpg: Para verificar firmas GPG
# apt-transport-https: Para repositorios HTTPS
apt install -y curl gpg apt-transport-https wget

print_success "Dependencias instaladas"

################################################################################
# 2. CONFIGURACIÓN DE CLAVE GPG DE MICROSOFT
################################################################################
print_header "2. CONFIGURANDO CLAVE GPG DE MICROSOFT"

print_info "Descargando clave GPG de Microsoft..."
# Descargar clave pública de Microsoft
# -qO-: Descarga silenciosa a stdout
# gpg --dearmor: Convierte clave ASCII a formato binario
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg

print_info "Instalando clave GPG..."
# install: Copia archivo con permisos específicos
# -D: Crea directorios padre si no existen
# -o root -g root: Propietario y grupo root
# -m 644: Permisos rw-r--r--
install -D -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft.gpg

# Limpiar archivo temporal
rm -f microsoft.gpg

print_success "Clave GPG de Microsoft instalada"

################################################################################
# 3. SELECCIÓN DE APLICACIONES
################################################################################
print_header "3. SELECCIÓN DE APLICACIONES"

print_info "¿Qué aplicaciones de Microsoft deseas instalar?"
echo ""
echo "  1) Microsoft Edge (navegador web)"
echo "  2) Visual Studio Code (editor de código)"
echo "  3) PowerShell (shell y scripting)"
echo "  4) .NET SDK 8.0 (desarrollo .NET)"
echo "  5) Todas las anteriores"
echo "  6) Personalizar selección"
echo "  7) Solo configurar repositorio"
echo ""

read -p "Selecciona una opción [1-7]: " choice

INSTALL_EDGE=false
INSTALL_VSCODE=false
INSTALL_POWERSHELL=false
INSTALL_DOTNET=false

case $choice in
    1)
        INSTALL_EDGE=true
        print_info "Se instalará: Microsoft Edge"
        ;;
    2)
        INSTALL_VSCODE=true
        print_info "Se instalará: Visual Studio Code"
        ;;
    3)
        INSTALL_POWERSHELL=true
        print_info "Se instalará: PowerShell"
        ;;
    4)
        INSTALL_DOTNET=true
        print_info "Se instalará: .NET SDK 8.0"
        ;;
    5)
        INSTALL_EDGE=true
        INSTALL_VSCODE=true
        INSTALL_POWERSHELL=true
        INSTALL_DOTNET=true
        print_info "Se instalarán: Todas las aplicaciones"
        ;;
    6)
        print_info "Selección personalizada:"
        echo ""
        read -p "¿Instalar Microsoft Edge? [s/N]: " resp
        [[ "$resp" =~ ^[Ss]$ ]] && INSTALL_EDGE=true
        
        read -p "¿Instalar Visual Studio Code? [s/N]: " resp
        [[ "$resp" =~ ^[Ss]$ ]] && INSTALL_VSCODE=true
        
        read -p "¿Instalar PowerShell? [s/N]: " resp
        [[ "$resp" =~ ^[Ss]$ ]] && INSTALL_POWERSHELL=true
        
        read -p "¿Instalar .NET SDK 8.0? [s/N]: " resp
        [[ "$resp" =~ ^[Ss]$ ]] && INSTALL_DOTNET=true
        
        echo ""
        print_info "Aplicaciones seleccionadas:"
        [ "$INSTALL_EDGE" = true ] && echo "  • Microsoft Edge"
        [ "$INSTALL_VSCODE" = true ] && echo "  • Visual Studio Code"
        [ "$INSTALL_POWERSHELL" = true ] && echo "  • PowerShell"
        [ "$INSTALL_DOTNET" = true ] && echo "  • .NET SDK 8.0"
        ;;
    7)
        print_info "Solo se configurará el repositorio"
        ;;
    4)
        print_info "Solo se configurará el repositorio"
        ;;
    *)
        print_error "Opción inválida"
        exit 1
        ;;
esac

echo ""

################################################################################
# 4. CONFIGURACIÓN DE REPOSITORIO DE MICROSOFT EDGE
################################################################################
if [ "$INSTALL_EDGE" = true ]; then
    print_header "4. CONFIGURANDO REPOSITORIO DE MICROSOFT EDGE"
    
    print_info "Creando archivo de fuentes para Microsoft Edge..."
    
    # Crear archivo .sources para Edge
    # Formato DEB822 (nuevo formato de fuentes de APT)
    cat > /etc/apt/sources.list.d/microsoft-edge.sources << 'EOF'
Types: deb
URIs: https://packages.microsoft.com/repos/edge
Suites: stable
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/microsoft.gpg
EOF
    
    print_success "Repositorio de Microsoft Edge configurado"
    
    print_info "Actualizando lista de paquetes..."
    apt update -qq
    
    print_info "Instalando Microsoft Edge..."
    # microsoft-edge-stable: Versión estable de Edge
    # Canal stable: Actualizaciones cada 4 semanas
    apt install -y microsoft-edge-stable
    
    print_success "Microsoft Edge instalado"
    
    # Verificar instalación
    if command -v microsoft-edge &> /dev/null; then
        EDGE_VERSION=$(microsoft-edge --version)
        print_success "Versión: $EDGE_VERSION"
    fi
fi

################################################################################
# 5. CONFIGURACIÓN DE REPOSITORIO DE VISUAL STUDIO CODE
################################################################################
if [ "$INSTALL_VSCODE" = true ]; then
    print_header "5. CONFIGURANDO REPOSITORIO DE VISUAL STUDIO CODE"
    
    print_info "Creando archivo de fuentes para VS Code..."
    
    # Crear archivo .sources para VS Code
    # Soporta múltiples arquitecturas: amd64, arm64, armhf
    cat > /etc/apt/sources.list.d/vscode.sources << 'EOF'
Types: deb
URIs: https://packages.microsoft.com/repos/code
Suites: stable
Components: main
Architectures: amd64 arm64 armhf
Signed-By: /usr/share/keyrings/microsoft.gpg
EOF
    
    print_success "Repositorio de VS Code configurado"
    
    print_info "Actualizando lista de paquetes..."
    apt update -qq
    
    print_info "Instalando Visual Studio Code..."
    # code: Visual Studio Code
    # También disponible: code-insiders (versión de desarrollo)
    apt install -y code
    
    print_success "Visual Studio Code instalado"
    
    # Verificar instalación
    if command -v code &> /dev/null; then
        VSCODE_VERSION=$(code --version | head -1)
        print_success "Versión: $VSCODE_VERSION"
    fi
fi

################################################################################
# 6. CONFIGURACIÓN DE REPOSITORIO DE PRODUCTOS MICROSOFT (PowerShell / .NET)
################################################################################
if [ "$INSTALL_POWERSHELL" = true ] || [ "$INSTALL_DOTNET" = true ]; then
    print_header "6. CONFIGURANDO REPOSITORIO DE PRODUCTOS MICROSOFT"
    
    print_info "Creando archivo de fuentes para Productos Microsoft..."
    
    # Crear archivo .sources para Productos Microsoft (.NET / PowerShell)
    # Importante: Usamos el repositorio específico de Debian 13 (Trixie)
    cat > /etc/apt/sources.list.d/microsoft-prod.list << 'EOF'
deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/debian/13/prod trixie main
EOF
    
    print_success "Repositorio de Productos Microsoft configurado"
    
    print_info "Actualizando lista de paquetes..."
    apt update -qq
fi

################################################################################
# 7. INSTALACIÓN DE POWERSHELL
################################################################################
if [ "$INSTALL_POWERSHELL" = true ]; then
    print_header "7. INSTALANDO POWERSHELL"
    
    print_info "PowerShell usa el mismo repositorio de Microsoft"
    apt update -qq
    
    print_info "Instalando PowerShell..."
    # powershell: Shell multiplataforma de Microsoft
    # - Scripting avanzado y automatización
    # - Gestión de sistemas Windows remotos
    # - Compatible con scripts de Windows PowerShell
    apt install -y powershell
    
    print_success "PowerShell instalado"
    
    if command -v pwsh &> /dev/null; then
        PWSH_VERSION=$(pwsh --version)
        print_success "Versión: $PWSH_VERSION"
    fi
fi

################################################################################
# 8. INSTALACIÓN DE .NET SDK
################################################################################
if [ "$INSTALL_DOTNET" = true ]; then
    print_header "8. INSTALANDO .NET SDK 8.0"
    
    print_info ".NET SDK usa el mismo repositorio de Microsoft"
    apt update -qq
    
    print_info "Instalando .NET SDK 8.0..."
    # dotnet-sdk-8.0: SDK de .NET 8.0 (LTS - Long Term Support)
    # - Desarrollo C#, F#, VB.NET
    # - ASP.NET Core para web
    # - Blazor, MAUI, Entity Framework Core
    apt install -y dotnet-sdk-8.0
    
    print_success ".NET SDK 8.0 instalado"
    
    if command -v dotnet &> /dev/null; then
        DOTNET_VERSION=$(dotnet --version)
        print_success "Versión: $DOTNET_VERSION"
        
        print_info "SDKs instalados:"
        dotnet --list-sdks | sed 's/^/  /'
    fi
fi

################################################################################
# 9. CONFIGURACIÓN POST-INSTALACIÓN
################################################################################
print_header "9. CONFIGURACIÓN POST-INSTALACIÓN"

if [ "$INSTALL_EDGE" = true ]; then
    print_info "Microsoft Edge:"
    echo "  • Ejecutable: microsoft-edge"
    echo "  • Ubicación: /usr/bin/microsoft-edge"
    echo "  • Configuración: ~/.config/microsoft-edge/"
    echo ""
fi

if [ "$INSTALL_VSCODE" = true ]; then
    print_info "Visual Studio Code:"
    echo "  • Ejecutable: code"
    echo "  • Ubicación: /usr/bin/code"
    echo "  • Configuración: ~/.config/Code/"
    echo "  • Extensiones: ~/.vscode/extensions/"
    echo ""
    
    print_info "Extensiones recomendadas para VS Code:"
    echo "  • ms-python.python - Python"
    echo "  • ms-dotnettools.csharp - C# (si instalaste .NET)"
    echo "  • dbaeumer.vscode-eslint - ESLint"
    echo "  • esbenp.prettier-vscode - Prettier"
    echo "  • ms-vscode.cpptools - C/C++"
    echo "  • ms-vscode.powershell - PowerShell (si instalaste PowerShell)"
    echo ""
fi

if [ "$INSTALL_POWERSHELL" = true ]; then
    print_info "PowerShell:"
    echo "  • Ejecutable: pwsh"
    echo "  • Ubicación: /usr/bin/pwsh"
    echo "  • Configuración: ~/.config/powershell/"
    echo "  • Perfil: ~/.config/powershell/Microsoft.PowerShell_profile.ps1"
    echo ""
    
    print_info "Comandos básicos de PowerShell:"
    echo "  • Iniciar: pwsh"
    echo "  • Ayuda: Get-Help <comando>"
    echo "  • Listar comandos: Get-Command"
    echo "  • Ver versión: \$PSVersionTable"
    echo ""
fi

if [ "$INSTALL_DOTNET" = true ]; then
    print_info ".NET SDK 8.0:"
    echo "  • Ejecutable: dotnet"
    echo "  • Ubicación: /usr/bin/dotnet"
    echo "  • Configuración: ~/.dotnet/"
    echo ""
    
    print_info "Comandos básicos de .NET:"
    echo "  • Crear proyecto consola: dotnet new console -n MiApp"
    echo "  • Crear proyecto web: dotnet new webapp -n MiWeb"
    echo "  • Compilar: dotnet build"
    echo "  • Ejecutar: dotnet run"
    echo "  • Publicar: dotnet publish"
    echo ""
    
    print_info "Plantillas disponibles:"
    echo "  • console - Aplicación de consola"
    echo "  • webapp - Aplicación web ASP.NET Core"
    echo "  • webapi - API web ASP.NET Core"
    echo "  • blazorserver - Aplicación Blazor Server"
    echo "  • classlib - Biblioteca de clases"
    echo ""
fi

################################################################################
# 10. RESUMEN FINAL
################################################################################
print_header "INSTALACIÓN COMPLETADA"

echo -e "${GREEN}✓ Repositorio de Microsoft configurado${NC}"
if [ "$INSTALL_EDGE" = true ]; then
    echo -e "${GREEN}✓ Microsoft Edge instalado${NC}"
fi
if [ "$INSTALL_VSCODE" = true ]; then
    echo -e "${GREEN}✓ Visual Studio Code instalado${NC}"
fi
if [ "$INSTALL_POWERSHELL" = true ]; then
    echo -e "${GREEN}✓ PowerShell instalado${NC}"
fi
if [ "$INSTALL_DOTNET" = true ]; then
    echo -e "${GREEN}✓ .NET SDK 8.0 instalado${NC}"
fi
echo ""

print_info "Ubicaciones importantes:"
echo "  • Clave GPG: /usr/share/keyrings/microsoft.gpg"
if [ "$INSTALL_EDGE" = true ]; then
    echo "  • Fuentes Edge: /etc/apt/sources.list.d/microsoft-edge.sources"
fi
if [ "$INSTALL_VSCODE" = true ]; then
    echo "  • Fuentes VS Code: /etc/apt/sources.list.d/vscode.sources"
fi
echo ""

print_info "Comandos útiles:"
if [ "$INSTALL_EDGE" = true ]; then
    echo "  • Abrir Edge: microsoft-edge"
    echo "  • Actualizar Edge: sudo apt update && sudo apt upgrade microsoft-edge-stable"
    echo ""
fi
if [ "$INSTALL_VSCODE" = true ]; then
    echo "  • Abrir VS Code: code"
    echo "  • Abrir carpeta: code /ruta/a/carpeta"
    echo "  • Instalar extensión: code --install-extension nombre-extension"
    echo "  • Actualizar VS Code: sudo apt update && sudo apt upgrade code"
    echo ""
fi
if [ "$INSTALL_POWERSHELL" = true ]; then
    echo "  • Iniciar PowerShell: pwsh"
    echo "  • Ejecutar script: pwsh -File script.ps1"
    echo "  • Actualizar PowerShell: sudo apt update && sudo apt upgrade powershell"
    echo ""
fi
if [ "$INSTALL_DOTNET" = true ]; then
    echo "  • Crear proyecto: dotnet new console -n MiApp"
    echo "  • Compilar: dotnet build"
    echo "  • Ejecutar: dotnet run"
    echo "  • Actualizar .NET: sudo apt update && sudo apt upgrade dotnet-sdk-8.0"
    echo ""
fi

if [ "$INSTALL_VSCODE" = true ]; then
    print_info "Configuración inicial de VS Code:"
    echo "  1. Abre VS Code: code"
    echo "  2. Instala extensiones recomendadas"
    echo "  3. Configura tus preferencias: Ctrl+,"
    echo "  4. Sincroniza configuración con cuenta de Microsoft/GitHub"
    echo ""
fi

print_warning "NOTA SOBRE ACTUALIZACIONES:"
echo "  Las aplicaciones se actualizarán automáticamente con:"
echo "  sudo apt update && sudo apt upgrade"
echo ""

print_success "¡Aplicaciones de Microsoft instaladas correctamente! 🚀"
