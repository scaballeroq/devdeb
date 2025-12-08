#!/bin/bash

################################################################################
# SELECT-DEV-LANGUAGE.SH - Instalación de Lenguajes de Programación
################################################################################
# Descripción:
#   Este script instala los lenguajes de programación seleccionados por el
#   usuario durante la primera ejecución o mediante selección interactiva.
#
# Lenguajes soportados:
#   - Ruby on Rails: Ruby + framework Rails
#   - Node.js: JavaScript runtime
#   - Go: Lenguaje de Google
#   - PHP: Con extensiones comunes + Composer
#   - Python: Última versión estable
#   - Elixir: Con Erlang + gestor Hex
#   - Rust: Vía rustup
#   - Java: Última versión LTS
#
# Método de instalación:
#   - Mayoría: Via Mise (gestor de versiones)
#   - PHP: Via APT (paquetes del sistema)
#   - Rust: Via rustup (instalador oficial)
#
# Variables de entorno utilizadas:
#   DEVDEB_FIRST_RUN_LANGUAGES: Lenguajes pre-seleccionados
#
# Uso de Mise:
#   - mise use --global: Instala y activa globalmente
#   - mise x: Ejecuta comando en contexto de Mise
#   - mise settings: Configura comportamiento de Mise
################################################################################

# Instalar lenguajes de programación por defecto
# Si existe la variable de primera ejecución, usarla
if [[ -v DEVDEB_FIRST_RUN_LANGUAGES ]]; then
  languages=$DEVDEB_FIRST_RUN_LANGUAGES
else
  # Si no, mostrar selector interactivo
  AVAILABLE_LANGUAGES=("Ruby on Rails" "Node.js" "Go" "PHP" "Python" "Elixir" "Rust" "Java")
  languages=$(gum choose "${AVAILABLE_LANGUAGES[@]}" --no-limit --height 10 --header "Select programming languages")
fi

# Si se seleccionó al menos un lenguaje, proceder con la instalación
if [[ -n "$languages" ]]; then
  # Iterar sobre cada lenguaje seleccionado
  for language in $languages; do
    case $language in
    
    # RUBY ON RAILS
    Ruby)
      # Instalar la última versión de Ruby globalmente
      mise use --global ruby@latest
      
      # Habilitar soporte para archivos .ruby-version (estilo rbenv)
      # Esto permite que Mise detecte automáticamente la versión de Ruby
      mise settings add idiomatic_version_file_enable_tools ruby
      
      # Instalar Rails gem (framework web)
      # mise x ruby: Ejecuta el comando en el contexto de Ruby gestionado por Mise
      # --no-document: No generar documentación (ahorra tiempo y espacio)
      mise x ruby -- gem install rails --no-document
      ;;
    
    # NODE.JS
    Node.js)
      # Instalar la versión LTS (Long Term Support) de Node.js
      # LTS es recomendado para producción por su estabilidad
      mise use --global node@lts
      ;;
    
    # GO
    Go)
      # Instalar la última versión de Go
      mise use --global go@latest
      ;;
    
    # PHP
    PHP)
      # PHP se instala desde repositorios del sistema (no via Mise)
      # Instalar PHP y extensiones comunes:
      # - curl: Cliente HTTP
      # - apcu: Cache en memoria
      # - intl: Internacionalización
      # - mbstring: Manejo de strings multibyte
      # - opcache: Cache de bytecode
      # - pgsql, mysql, sqlite3: Drivers de bases de datos
      # - redis: Cliente Redis
      # - xml: Procesamiento XML
      # - zip: Manejo de archivos ZIP
      sudo apt -y install php php-{curl,apcu,intl,mbstring,opcache,pgsql,mysql,sqlite3,redis,xml,zip} --no-install-recommends
      
      # Instalar Composer (gestor de dependencias de PHP)
      # Descargar instalador
      php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
      
      # Ejecutar instalador silenciosamente
      php composer-setup.php --quiet && sudo mv composer.phar /usr/local/bin/composer
      
      # Limpiar instalador
      rm composer-setup.php
      ;;
    
    # PYTHON
    Python)
      # Instalar la última versión de Python
      mise use --global python@latest
      ;;
    
    # ELIXIR
    Elixir)
      # Elixir requiere Erlang (la VM sobre la que corre)
      # Instalar última versión de Erlang
      mise use --global erlang@latest
      
      # Instalar última versión de Elixir
      mise use --global elixir@latest
      
      # Instalar Hex (gestor de paquetes de Elixir)
      # mise x elixir: Ejecuta en contexto de Elixir
      # mix local.hex: Instala Hex localmente
      # --force: No pedir confirmación
      mise x elixir -- mix local.hex --force
      ;;
    
    # RUST
    Rust)
      # Rust se instala via rustup (instalador oficial)
      # curl: Descarga el script de instalación
      # --proto '=https': Solo usar HTTPS
      # --tlsv1.2: Usar TLS 1.2 o superior
      # -sSf: Silent, show errors, fail on error
      # -y: Instalación no interactiva (acepta defaults)
      bash -c "$(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs)" -- -y
      ;;
    
    # JAVA
    Java)
      # Instalar la última versión de Java
      mise use --global java@latest
      ;;
    
    esac
  done
fi

# Después de la instalación, los lenguajes estarán disponibles en el PATH
# Mise se encarga de añadirlos automáticamente cuando se activa en el shell
