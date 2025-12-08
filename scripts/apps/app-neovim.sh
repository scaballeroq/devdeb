#!/bin/bash

################################################################################
# APP-NEOVIM.SH - Instalación y Configuración de Neovim con LazyVim
################################################################################
# Descripción:
#   Este script instala la última versión estable de Neovim y lo configura
#   con LazyVim, una distribución moderna de Neovim con plugins preconfigurados.
#
# Componentes instalados:
#   - Neovim: Editor de texto modal (fork de Vim)
#   - LazyVim: Distribución de Neovim con configuración lista para usar
#   - luarocks: Gestor de paquetes para Lua
#   - tree-sitter-cli: Parser para resaltado de sintaxis avanzado
#
# Configuraciones aplicadas:
#   1. Tema Tokyo Night por defecto
#   2. Transparencia del terminal
#   3. Desactivación de scroll animado
#   4. Desactivación de números de línea relativos
#   5. Neo-tree como explorador de archivos por defecto
#   6. Lanzador de escritorio para abrir en Alacritty
#
# Estructura de configuración de Neovim:
#   ~/.config/nvim/
#   ├── init.lua                    # Archivo de entrada
#   ├── lua/
#   │   ├── config/
#   │   │   └── options.lua         # Opciones de Neovim
#   │   └── plugins/
#   │       ├── theme.lua           # Configuración de tema
#   │       └── *.lua               # Otros plugins
#   └── plugin/
#       └── after/
#           └── transparency.lua    # Transparencia
#
# Documentación:
#   - Neovim: https://neovim.io/
#   - LazyVim: https://www.lazyvim.org/
################################################################################

# Cambiar al directorio temporal para descargas
cd /tmp

# Descargar la última versión estable de Neovim para Linux x86_64
wget -O nvim.tar.gz "https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz"

# Extraer el archivo comprimido
tar -xf nvim.tar.gz

# Instalar el binario de Neovim en /usr/local/bin
# Esto lo hace disponible en el PATH del sistema
sudo install nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim

# Copiar las librerías necesarias
sudo cp -R nvim-linux-x86_64/lib /usr/local/

# Copiar archivos compartidos (runtime, documentación, etc.)
sudo cp -R nvim-linux-x86_64/share /usr/local/

# Limpiar archivos temporales
rm -rf nvim-linux-x86_64 nvim.tar.gz

# Volver al directorio anterior
cd -

# Instalar dependencias para resolver advertencias de :checkhealth en LazyVim
# luarocks: Gestor de paquetes Lua (para plugins que requieren módulos Lua)
# tree-sitter-cli: CLI de Tree-sitter para parsers de sintaxis
sudo apt install -y luarocks tree-sitter-cli

# Solo configurar si Neovim nunca ha sido ejecutado
# Esto evita sobrescribir configuraciones existentes del usuario
if [ ! -d "$HOME/.config/nvim" ]; then
  # Clonar el starter de LazyVim
  # LazyVim es una distribución de Neovim con plugins y configuraciones preestablecidas
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  
  # Eliminar el directorio .git para que el usuario pueda añadirlo a su propio repo
  rm -rf ~/.config/nvim/.git

  # Configurar transparencia para que coincida con el terminal
  # Esto hace que el fondo de Neovim sea transparente
  mkdir -p ~/.config/nvim/plugin/after
  cp ~/.local/share/devdeb/configs/neovim/transparency.lua ~/.config/nvim/plugin/after/

  # Establecer Tokyo Night como tema por defecto
  # Tokyo Night es un tema oscuro popular con buen contraste
  cp ~/.local/share/devdeb/themes/tokyo-night/neovim.lua ~/.config/nvim/lua/plugins/theme.lua

  # Desactivar el scroll animado (puede ser molesto para algunos usuarios)
  cp ~/.local/share/devdeb/configs/neovim/snacks-animated-scrolling-off.lua ~/.config/nvim/lua/plugins/

  # Desactivar números de línea relativos
  # Los números relativos muestran distancias desde la línea actual
  # Algunos usuarios prefieren números absolutos
  echo "vim.opt.relativenumber = false" >>~/.config/nvim/lua/config/options.lua

  # Asegurar que neo-tree (explorador de archivos) se use por defecto
  cp ~/.local/share/devdeb/configs/neovim/lazyvim.json ~/.config/nvim/
fi

# Reemplazar el lanzador de escritorio para que Neovim se abra dentro de Alacritty
# Esto proporciona una mejor experiencia visual con transparencia y fuentes
if [[ -d ~/.local/share/applications ]]; then
  # Eliminar lanzadores existentes del sistema
  sudo rm -rf /usr/share/applications/nvim.desktop
  sudo rm -rf /usr/local/share/applications/nvim.desktop
  
  # Crear lanzador personalizado que abre Neovim en Alacritty
  source ~/.local/share/devdeb/applications/Neovim.sh
fi

# Al primer inicio, LazyVim descargará e instalará automáticamente todos los plugins
# Esto puede tomar unos minutos la primera vez
