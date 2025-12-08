#!/bin/bash

################################################################################
# MISE.SH - Instalación de Mise (Gestor de Versiones de Lenguajes)
################################################################################
# Descripción:
#   Mise es un gestor de versiones de herramientas de desarrollo que permite
#   instalar y cambiar entre múltiples versiones de lenguajes de programación
#   y otras herramientas CLI.
#
# Características de Mise:
#   - Sucesor espiritual de asdf
#   - Más rápido que asdf (escrito en Rust)
#   - Compatible con archivos .tool-versions de asdf
#   - Soporta múltiples lenguajes: Ruby, Node, Python, Go, etc.
#   - Gestión de variables de entorno por proyecto
#   - Activación automática al entrar en directorios
#
# Lenguajes/herramientas soportadas:
#   - Ruby, Node.js, Python, Go, PHP, Elixir, Rust, Java
#   - Y muchas más herramientas CLI
#
# Uso básico después de la instalación:
#   mise use --global node@20    # Instalar Node 20 globalmente
#   mise use ruby@3.2.0           # Instalar Ruby 3.2.0 en proyecto actual
#   mise list                     # Ver versiones instaladas
#   mise ls-remote node           # Ver versiones disponibles de Node
#
# Documentación: https://mise.jdx.dev/
#
# Adaptaciones para Debian:
#   - El repositorio de Mise soporta Debian directamente
#   - No requiere cambios significativos
################################################################################

# Actualizar repositorios e instalar dependencias necesarias
sudo apt update -y && sudo apt install -y gpg wget curl

# Crear directorio para claves GPG de repositorios
# -d: crear directorio, -m 755: permisos rwxr-xr-x
sudo install -dm 755 /etc/apt/keyrings

# Descargar y añadir la clave GPG del repositorio de Mise
# wget -qO -: Descargar silenciosamente y enviar a stdout
# gpg --dearmor: Convertir clave ASCII a formato binario
# tee: Escribir a archivo y también a stdout
# 1>/dev/null: Suprimir salida estándar
wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg 1>/dev/null

# Añadir el repositorio de Mise a las fuentes de APT
# [signed-by=...]: Especifica qué clave GPG usar para verificar paquetes
# arch=$(dpkg --print-architecture): Detecta arquitectura del sistema
# stable main: Canal estable, componente principal
echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=$(dpkg --print-architecture)] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list

# Actualizar lista de paquetes con el nuevo repositorio
sudo apt update

# Instalar Mise
sudo apt install -y mise

# Después de la instalación, Mise debe ser activado en el shell
# Esto normalmente se hace en ~/.bashrc con:
# eval "$(mise activate bash)"
# El script de configuración de shell (a-shell.sh) debería incluir esto
