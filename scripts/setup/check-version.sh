#!/bin/bash

################################################################################
# CHECK-VERSION.SH - Verificación de Sistema Operativo y Arquitectura
################################################################################
# Descripción:
#   Este script verifica que el sistema cumple con los requisitos mínimos
#   para ejecutar DevDeb. Comprueba la distribución, versión y arquitectura.
#
# Verificaciones realizadas:
#   1. Existencia del archivo /etc/os-release
#   2. Distribución: Ubuntu (adaptar a Debian)
#   3. Versión: 24.04 o superior (adaptar a Debian 13+)
#   4. Arquitectura: x86_64 o i686 (sistemas de 64 o 32 bits)
#
# Adaptaciones para Debian:
#   - Cambiar verificación de "ubuntu" a "debian"
#   - Cambiar verificación de versión a 13 o superior
#   - En Debian, VERSION_ID puede ser "13" o simplemente no existir en testing
#
# Variables utilizadas de /etc/os-release:
#   ID: Identificador de la distribución (ubuntu, debian, etc.)
#   VERSION_ID: Número de versión (24.04, 13, etc.)
#
# Códigos de salida:
#   0: Sistema compatible
#   1: Sistema no compatible (aborta instalación)
################################################################################

# Verificar que existe el archivo /etc/os-release
# Este archivo contiene información sobre la distribución Linux
if [ ! -f /etc/os-release ]; then
  # tput setaf 1 establece el color rojo para el mensaje de error
  echo "$(tput setaf 1)Error: Unable to determine OS. /etc/os-release file not found."
  echo "Installation stopped."
  exit 1
fi

# Cargar las variables del archivo /etc/os-release
# Esto define variables como ID, VERSION_ID, NAME, etc.
. /etc/os-release

# Verificar si se está ejecutando en Ubuntu 24.04 o superior
# ADAPTACIÓN PARA DEBIAN: Cambiar esta sección
if [ "$ID" != "ubuntu" ] || [ $(echo "$VERSION_ID >= 24.04" | bc) != 1 ]; then
  echo "$(tput setaf 1)Error: OS requirement not met"
  echo "You are currently running: $ID $VERSION_ID"
  echo "OS required: Ubuntu 24.04 or higher"
  echo "Installation stopped."
  exit 1
fi

# VERSIÓN ADAPTADA PARA DEBIAN (comentada):
# if [ "$ID" != "debian" ]; then
#   echo "$(tput setaf 1)Error: OS requirement not met"
#   echo "You are currently running: $ID $VERSION_ID"
#   echo "OS required: Debian 13 (Trixie) or higher"
#   echo "Installation stopped."
#   exit 1
# fi
#
# # Verificar versión solo si VERSION_ID está definido
# if [ -n "$VERSION_ID" ] && [ $(echo "$VERSION_ID >= 13" | bc) != 1 ]; then
#   echo "$(tput setaf 1)Error: Debian version too old"
#   echo "You are currently running: Debian $VERSION_ID"
#   echo "Version required: Debian 13 (Trixie) or higher"
#   echo "Installation stopped."
#   exit 1
# fi

# Verificar la arquitectura del sistema
# uname -m devuelve la arquitectura de la máquina
ARCH=$(uname -m)

# Solo se soportan arquitecturas x86 (64-bit y 32-bit)
if [ "$ARCH" != "x86_64" ] && [ "$ARCH" != "i686" ]; then
  echo "$(tput setaf 1)Error: Unsupported architecture detected"
  echo "Current architecture: $ARCH"
  echo "This installation is only supported on x86 architectures (x86_64 or i686)."
  echo "Installation stopped."
  exit 1
fi

# Si llegamos aquí, todas las verificaciones pasaron
# El script continúa sin imprimir nada (salida exitosa silenciosa)
