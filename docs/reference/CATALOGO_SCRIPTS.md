# Catálogo Completo de Scripts de Omakub

## 📑 Índice de Scripts por Categoría

Este documento proporciona una referencia rápida de todos los scripts disponibles en Omakub, organizados por categoría y función.

---

## 🚀 Scripts Principales de Arranque

### `boot.sh`
**Ubicación**: Raíz del proyecto  
**Función**: Script de arranque inicial  
**Descripción**: Punto de entrada principal que clona el repositorio y comienza la instalación  
**Ejecuta**:
- Muestra logo ASCII
- Actualiza APT
- Instala git
- Clona repositorio Omakub
- Ejecuta install.sh

### `install.sh`
**Ubicación**: Raíz del proyecto  
**Función**: Coordinador principal de instalación  
**Descripción**: Orquesta toda la instalación de componentes  
**Ejecuta**:
- Verificación de versión del SO
- Solicitud de elecciones al usuario
- Instalación de terminal
- Instalación de desktop (si GNOME)

### `ascii.sh`
**Ubicación**: Raíz del proyecto  
**Función**: Visualización de logo  
**Descripción**: Muestra el logo de Omakub con degradado de colores

---

## ✅ Scripts de Verificación

### `install/check-version.sh`
**Función**: Verificación de sistema operativo  
**Verifica**:
- Existencia de /etc/os-release
- Distribución: Ubuntu 24.04+ (adaptar a Debian 13+)
- Arquitectura: x86_64 o i686

### `install/identification.sh`
**Función**: Recopilación de identidad del usuario  
**Solicita**:
- Nombre completo
- Dirección de email
**Uso**: Configuración de git y autocompletado

### `install/first-run-choices.sh`
**Función**: Selección interactiva de componentes  
**Solicita**:
- Aplicaciones opcionales (solo GNOME)
- Lenguajes de programación
- Bases de datos

---

## 🖥️ Scripts de Terminal

### Coordinador

#### `install/terminal.sh`
**Función**: Ejecutor de instaladores de terminal  
**Ejecuta**:
- Actualización del sistema
- Instalación de curl, git, unzip
- Todos los scripts en `install/terminal/*.sh`

### Configuración de Shell

#### `install/terminal/a-shell.sh`
**Función**: Configuración de Bash  
**Configura**:
- ~/.bashrc (aliases, prompt, variables)
- ~/.inputrc (autocompletado, historial)
- Carga PATH para instaladores posteriores

#### `install/terminal/libraries.sh`
**Función**: Instalación de librerías de desarrollo  
**Instala**:
- build-essential
- pkg-config
- autoconf
- Otras dependencias comunes

### Aplicaciones de Terminal

#### `install/terminal/app-btop.sh`
**Función**: Monitor de sistema  
**Instala**: btop (monitor de recursos mejorado tipo htop)

#### `install/terminal/app-fastfetch.sh`
**Función**: Información del sistema  
**Instala**: fastfetch (neofetch mejorado)  
**Configura**: `configs/fastfetch.jsonc`

#### `install/terminal/app-github-cli.sh`
**Función**: CLI de GitHub  
**Instala**: gh (herramienta oficial de GitHub)  
**Permite**: Gestionar repos, PRs, issues desde terminal

#### `install/terminal/app-lazydocker.sh`
**Función**: Gestión visual de Docker  
**Instala**: lazydocker (TUI para Docker)  
**Características**: Ver contenedores, logs, stats

#### `install/terminal/app-lazygit.sh`
**Función**: Gestión visual de Git  
**Instala**: lazygit (TUI para Git)  
**Características**: Commits, branches, merges simplificados

#### `install/terminal/app-neovim.sh`
**Función**: Editor Neovim con LazyVim  
**Instala**:
- Neovim stable
- LazyVim (distribución de Neovim)
- luarocks, tree-sitter-cli
**Configura**:
- Tema Tokyo Night
- Transparencia
- Neo-tree
- Desactiva números relativos

#### `install/terminal/app-zellij.sh`
**Función**: Multiplexor de terminal  
**Instala**: zellij (alternativa moderna a tmux)  
**Configura**: `configs/zellij.kdl`

### Herramientas de Desarrollo

#### `install/terminal/docker.sh`
**Función**: Instalación de Docker  
**Instala**:
- docker-ce (Community Edition)
- docker-ce-cli
- containerd.io
- docker-buildx-plugin
- docker-compose-plugin
- docker-ce-rootless-extras
**Configura**:
- Usuario en grupo docker
- Límites de logs (10MB × 5 archivos)

#### `install/terminal/mise.sh`
**Función**: Gestor de versiones  
**Instala**: mise (sucesor de asdf)  
**Soporta**: Ruby, Node, Python, Go, PHP, Elixir, Rust, Java  
**URL**: https://mise.jdx.dev/

### Selección de Lenguajes y Bases de Datos

#### `install/terminal/select-dev-language.sh`
**Función**: Instalación de lenguajes de programación  
**Lenguajes disponibles**:
- **Ruby on Rails**: Ruby latest + Rails gem
- **Node.js**: Node LTS
- **Go**: Go latest
- **PHP**: PHP + extensiones + Composer
- **Python**: Python latest
- **Elixir**: Erlang + Elixir + Hex
- **Rust**: Via rustup
- **Java**: Java latest

#### `install/terminal/select-dev-storage.sh`
**Función**: Instalación de bases de datos  
**Bases de datos** (en Docker):
- MySQL
- PostgreSQL
- Redis

#### `install/terminal/set-git.sh`
**Función**: Configuración de Git  
**Configura**:
- user.name
- user.email
- Otras configuraciones globales

### Aplicaciones Opcionales de Terminal

#### `install/terminal/apps-terminal.sh`
**Función**: Instalador de apps adicionales de terminal  
**Ejecuta**: Scripts de aplicaciones opcionales

---

## 🎨 Scripts de Desktop

### Coordinador

#### `install/desktop.sh`
**Función**: Ejecutor de instaladores de desktop  
**Ejecuta**:
- Todos los scripts en `install/desktop/*.sh`
- Pregunta por reinicio al finalizar

### Gestores de Paquetes

#### `install/desktop/a-flatpak.sh`
**Función**: Instalación de Flatpak  
**Instala**: Flatpak  
**Añade**: Repositorio Flathub

### Navegadores

#### `install/desktop/app-chrome.sh`
**Función**: Google Chrome  
**Instala**: Chrome stable  
**Añade**: Repositorio oficial de Google

### Terminales

#### `install/desktop/app-alacritty.sh`
**Función**: Terminal acelerada por GPU  
**Instala**: Alacritty  
**Configura**: `configs/alacritty.toml`  
**Características**: Soporte para temas, transparencia

### Editores

#### `install/desktop/app-vscode.sh`
**Función**: Visual Studio Code  
**Instala**: VSCode  
**Configura**: Extensiones y settings  
**Archivo**: `configs/vscode.json`

#### `install/desktop/app-typora.sh`
**Función**: Editor Markdown  
**Instala**: Typora (WYSIWYG)  
**Configura**: Temas personalizados

### Utilidades de Captura y Clipboard

#### `install/desktop/app-flameshot.sh`
**Función**: Capturas de pantalla  
**Instala**: Flameshot (herramienta avanzada)

#### `install/desktop/app-gnome-sushi.sh`
**Función**: Previsualizador de archivos  
**Instala**: GNOME Sushi (vista previa con espacio)

#### `install/desktop/app-wl-clipboard.sh`
**Función**: Portapapeles Wayland  
**Instala**: wl-clipboard (soporte Wayland)

#### `install/desktop/app-localsend.sh`
**Función**: Transferencia de archivos  
**Instala**: LocalSend (compartir en red local)

### Ofimática

#### `install/desktop/app-libreoffice.sh`
**Función**: Suite ofimática  
**Instala**: LibreOffice completo

### Multimedia

#### `install/desktop/app-vlc.sh`
**Función**: Reproductor multimedia  
**Instala**: VLC Media Player

#### `install/desktop/app-pinta.sh`
**Función**: Editor de imágenes simple  
**Instala**: Pinta

#### `install/desktop/app-xournalpp.sh`
**Función**: Notas manuscritas  
**Instala**: Xournal++ (para stylus/tablet)

### Comunicación

#### `install/desktop/app-signal.sh`
**Función**: Mensajería segura  
**Instala**: Signal Desktop

### Productividad

#### `install/desktop/app-obsidian.sh`
**Función**: Gestión de conocimiento  
**Instala**: Obsidian (notas interconectadas)

### Herramientas del Sistema

#### `install/desktop/app-gnome-tweak-tool.sh`
**Función**: Herramienta de ajustes GNOME  
**Instala**: GNOME Tweaks

### Configuración de GNOME

#### `install/desktop/set-gnome-settings.sh`
**Función**: Configuraciones básicas de GNOME  
**Configura**:
- Centrar ventanas nuevas
- Fuente monoespaciada: CaskaydiaMono Nerd Font
- Números de semana en calendario
- Desactivar sensor de luz ambiental

#### `install/desktop/set-gnome-hotkeys.sh`
**Función**: Atajos de teclado  
**Configura**: Atajos personalizados para productividad

#### `install/desktop/set-gnome-extensions.sh`
**Función**: Extensiones de GNOME  
**Instala**: Extensiones útiles de GNOME Shell

#### `install/desktop/set-gnome-theme.sh`
**Función**: Tema visual  
**Aplica**: Tema personalizado de Omakub

#### `install/desktop/set-dock.sh`
**Función**: Configuración del dock  
**Configura**: Posición, tamaño, apps fijadas

#### `install/desktop/set-app-grid.sh`
**Función**: Organización de aplicaciones  
**Ordena**: Aplicaciones en el grid de GNOME

#### `install/desktop/set-alacritty-default.sh`
**Función**: Terminal por defecto  
**Establece**: Alacritty como terminal predeterminada

#### `install/desktop/set-xcompose.sh`
**Función**: Composición de caracteres  
**Configura**: Atajos para caracteres especiales

#### `install/desktop/set-framework-text-scaling.sh`
**Función**: Escalado de texto para Framework  
**Configura**: Escalado específico para laptops Framework

### Fuentes

#### `install/desktop/fonts.sh`
**Función**: Instalación de fuentes  
**Instala**:
- Nerd Fonts (iconos en terminal)
- CaskaydiaMono
- JetBrains Mono
- Otras fuentes de desarrollo

### Lanzador de Aplicaciones

#### `install/desktop/ulauncher.sh`
**Función**: Lanzador de aplicaciones  
**Instala**: Ulauncher (tipo Spotlight/Alfred)  
**Configura**: `configs/ulauncher.json`

### Aplicaciones Opcionales

#### `install/desktop/select-optional-apps.sh`
**Función**: Instalador de apps opcionales  
**Ejecuta**: Scripts de apps seleccionadas por el usuario

#### Aplicaciones Opcionales Disponibles (`install/desktop/optional/`)

- **app-1password.sh**: Gestor de contraseñas
- **app-spotify.sh**: Música en streaming
- **app-discord.sh**: Comunicación para comunidades
- **app-zoom.sh**: Videoconferencias
- **app-dropbox.sh**: Almacenamiento en nube
- **app-brave.sh**: Navegador centrado en privacidad
- **app-cursor.sh**: Editor de código con IA
- **app-gimp.sh**: Editor de imágenes avanzado
- **app-audacity.sh**: Editor de audio
- **app-obs-studio.sh**: Grabación y streaming
- **app-mainline-kernels.sh**: Gestor de kernels
- **app-doom-emacs.sh**: Distribución de Emacs
- Y más...

---

## 🔧 Utilidades de Línea de Comandos

### Script Principal

#### `bin/omakub`
**Función**: Comando principal de Omakub  
**Muestra**: Menú interactivo con opciones  
**Opciones**:
- Theme: Cambiar tema
- Font: Cambiar fuente
- Update: Actualizar Omakub
- Install: Instalar componentes
- Uninstall: Desinstalar componentes
- Manual: Ver manual

### Subcomandos (`bin/omakub-sub/`)

#### `header.sh`
**Función**: Mostrar cabecera de Omakub  
**Muestra**: Logo y versión

#### `menu.sh`
**Función**: Menú principal interactivo  
**Usa**: gum para selección de opciones

#### `theme.sh`
**Función**: Cambiar tema de colores  
**Temas disponibles**:
- Tokyo Night
- Catppuccin (Mocha, Latte, Frappe, Macchiato)
- Dracula
- Nord
- Gruvbox
- One Dark
- Solarized
- Y más...

#### `font.sh`
**Función**: Cambiar fuente de terminal  
**Fuentes disponibles**: Todas las Nerd Fonts

#### `font-size.sh`
**Función**: Cambiar tamaño de fuente  
**Aplica a**: Alacritty y otros terminales

#### `update.sh`
**Función**: Actualizar Omakub  
**Ejecuta**:
- git pull del repositorio
- Migraciones si es necesario

#### `install.sh`
**Función**: Instalador de componentes individuales  
**Permite**: Instalar apps/herramientas específicas

#### `uninstall.sh`
**Función**: Desinstalador de componentes  
**Permite**: Eliminar apps/herramientas instaladas

#### `migrate.sh`
**Función**: Ejecutor de migraciones  
**Ejecuta**: Scripts de migración entre versiones

#### `manual.sh`
**Función**: Manual de usuario  
**Muestra**: Documentación de uso

---

## 🎨 Temas

### Ubicación: `themes/`

Cada tema incluye configuraciones para:
- Alacritty
- Neovim
- Otros editores

### Temas Disponibles

1. **Tokyo Night** (predeterminado)
   - Oscuro, alto contraste
   - Colores vibrantes

2. **Catppuccin**
   - Variantes: Mocha, Latte, Frappe, Macchiato
   - Paleta pastel suave

3. **Dracula**
   - Oscuro con acentos púrpura
   - Popular en la comunidad

4. **Nord**
   - Paleta ártica
   - Colores fríos

5. **Gruvbox**
   - Retro, cálido
   - Variantes light/dark

6. **One Dark**
   - Basado en Atom
   - Oscuro equilibrado

7. **Solarized**
   - Científicamente diseñado
   - Variantes light/dark

---

## 📝 Archivos de Configuración

### Ubicación: `configs/`

#### `bashrc`
**Función**: Configuración de Bash  
**Incluye**:
- Aliases útiles
- Prompt personalizado
- Integración con herramientas
- Variables de entorno

#### `inputrc`
**Función**: Configuración de readline  
**Incluye**:
- Autocompletado case-insensitive
- Navegación en historial
- Búsqueda incremental

#### `alacritty.toml`
**Función**: Configuración de Alacritty  
**Incluye**:
- Fuente y tamaño
- Tema de colores
- Transparencia
- Atajos de teclado

#### `zellij.kdl`
**Función**: Configuración de Zellij  
**Incluye**:
- Layouts
- Keybindings
- Temas

#### `btop.conf`
**Función**: Configuración de btop  
**Incluye**:
- Tema de colores
- Actualización de stats
- Visualización

#### `fastfetch.jsonc`
**Función**: Configuración de fastfetch  
**Incluye**:
- Módulos a mostrar
- Formato de salida
- Logo ASCII

#### `vscode.json`
**Función**: Configuración de VSCode  
**Incluye**:
- Settings
- Extensiones recomendadas
- Keybindings

#### `ulauncher.json`
**Función**: Configuración de Ulauncher  
**Incluye**:
- Tema
- Atajos
- Extensiones

#### `xcompose`
**Función**: Composición de caracteres  
**Incluye**: Atajos para caracteres especiales

#### `neovim/`
**Función**: Configuraciones de Neovim  
**Archivos**:
- transparency.lua
- lazyvim.json
- snacks-animated-scrolling-off.lua

---

## 🔄 Scripts de Migración

### Ubicación: `migrations/`

Scripts numerados que se ejecutan al actualizar Omakub para aplicar cambios necesarios entre versiones.

---

## 🚀 Lanzadores de Aplicaciones

### Ubicación: `applications/`

Archivos .sh que crean lanzadores .desktop para aplicaciones:
- About.sh
- Activity.sh
- Basecamp.sh
- Docker.sh
- HEY.sh
- Neovim.sh
- Omakub.sh
- WhatsApp.sh

---

## 📊 Resumen de Categorías

| Categoría | Número de Scripts | Ubicación |
|-----------|-------------------|-----------|
| Scripts principales | 3 | Raíz |
| Verificación | 3 | install/ |
| Terminal | ~17 | install/terminal/ |
| Desktop | ~30 | install/desktop/ |
| Desktop opcionales | ~22 | install/desktop/optional/ |
| Utilidades bin | ~12 | bin/omakub-sub/ |
| Temas | ~72 | themes/ |
| Migraciones | ~15 | migrations/ |
| Lanzadores | ~8 | applications/ |
| **TOTAL** | **~182** | - |

---

## 🔍 Cómo Usar Este Catálogo

1. **Buscar por función**: Usa Ctrl+F para buscar palabras clave
2. **Explorar por categoría**: Navega las secciones organizadas
3. **Ejecutar scripts individuales**: Usa `source` para ejecutar scripts específicos
4. **Adaptar para Debian**: Revisa las notas de adaptación en cada script

---

## 📚 Referencias Adicionales

- **README.md**: Guía completa de uso
- **Scripts comentados**: Cada script en devdeb/ tiene comentarios detallados
- **Documentación oficial**: https://omakub.org

---

**Última actualización**: 2025-12-08
