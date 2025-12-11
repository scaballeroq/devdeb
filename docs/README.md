# DevDeb - Configuración Automática de Desarrollador para Debian 13 Trixie

## 📋 Descripción

DevDeb es un sistema de instalación y configuración automática para convertir una instalación fresca de **Debian 13 (Trixie)** en un entorno de desarrollo completo, moderno y hermoso. Está basado en **DevDeb** (para Ubuntu) y adaptado específicamente para Debian.

Este proyecto instala y configura:
- 🖥️ **Herramientas de terminal** (shell, editores, utilidades)
- 🎨 **Aplicaciones de escritorio** (navegadores, editores, comunicación)
- 🔧 **Entornos de desarrollo** (lenguajes de programación, bases de datos)
- 🎭 **Temas y personalización** (fuentes, colores, atajos de teclado)

## 🎯 Requisitos

- **Sistema Operativo**: Debian 13 (Trixie) - instalación fresca recomendada
- **Arquitectura**: x86_64 (64-bit)
- **Entorno de Escritorio**: GNOME (recomendado) o solo terminal
- **Conexión a Internet**: Requerida para descargar paquetes
- **Privilegios**: Acceso sudo

## 🚀 Instalación Rápida

### Instalación Completa (Un Solo Comando)

```bash
wget -qO- https://raw.githubusercontent.com/TU_USUARIO/devdeb/main/boot.sh | bash
```

Este comando:
1. Actualiza el sistema
2. Instala git
3. Clona el repositorio en `~/.local/share/devdeb`
4. Ejecuta el instalador principal
5. Te pedirá elegir aplicaciones, lenguajes y bases de datos

## 📦 Componentes Principales

### 🔹 Scripts de Arranque

#### `boot.sh`
Script de arranque inicial que:
- Muestra el logo ASCII de DevDeb
- Verifica que sea una instalación de Ubuntu 24.04+ (adaptar para Debian)
- Actualiza repositorios APT
- Instala git
- Clona el repositorio de DevDeb
- Inicia la instalación principal

#### `install.sh`
Script principal de instalación que:
- Verifica la versión del sistema operativo
- Configura trap de errores para reintentos
- Solicita elecciones de aplicaciones (usando gum)
- Detecta si está en GNOME
- Instala herramientas de terminal
- Instala herramientas de escritorio (solo en GNOME)
- Configura opciones de suspensión durante la instalación

#### `ascii.sh`
Muestra el logo de DevDeb con degradado de colores (cyan a azul)

### 🔹 Herramientas de Terminal

Ubicación: `install/terminal/`

#### Shell y Configuración Básica

**`a-shell.sh`** - Configura Bash
- Respalda `.bashrc` existente
- Copia configuración de DevDeb
- Configura `.inputrc` para mejor autocompletado

**`libraries.sh`** - Instala librerías de desarrollo
- build-essential
- pkg-config
- autoconf
- Otras dependencias comunes

#### Aplicaciones de Terminal

**`app-btop.sh`** - Monitor de sistema
- Instalación de btop (monitor de recursos mejorado)
- Configuración predeterminada

**`app-fastfetch.sh`** - Información del sistema
- Muestra información del sistema con estilo
- Configuración personalizada en `configs/fastfetch.jsonc`

**`app-github-cli.sh`** - GitHub CLI (gh)
- Herramienta oficial de GitHub para terminal
- Permite gestionar repos, PRs, issues desde CLI

**`app-lazydocker.sh`** - Gestión de Docker
- Interfaz TUI para gestionar contenedores Docker
- Visualización de logs, stats, etc.

**`app-lazygit.sh`** - Gestión de Git
- Interfaz TUI para operaciones Git
- Simplifica commits, branches, merges

**`app-neovim.sh`** - Editor Neovim
- Descarga última versión estable
- Configura LazyVim (distribución de Neovim)
- Instala plugins y dependencias
- Configura tema Tokyo Night
- Desactiva números de línea relativos
- Configura transparencia

**`app-zellij.sh`** - Multiplexor de terminal
- Alternativa moderna a tmux
- Configuración en `configs/zellij.kdl`

#### Docker

**`docker.sh`** - Instalación de Docker
- Añade repositorio oficial de Docker
- Instala Docker Engine y plugins
- Añade usuario al grupo docker
- Configura límites de logs (10MB, 5 archivos)

#### Gestión de Versiones

**`mise.sh`** - Gestor de versiones de lenguajes
- Instala mise (sucesor de asdf)
- Permite gestionar múltiples versiones de Ruby, Node, Python, etc.
- URL: https://mise.jdx.dev/

#### Configuración de Desarrollo

**`select-dev-language.sh`** - Selección de lenguajes
Lenguajes disponibles:
- **Ruby on Rails**: Instala Ruby latest + Rails gem
- **Node.js**: Instala Node LTS
- **Go**: Instala Go latest
- **PHP**: Instala PHP + extensiones (curl, mysql, redis, etc.) + Composer
- **Python**: Instala Python latest
- **Elixir**: Instala Erlang + Elixir + Hex
- **Rust**: Instala Rust via rustup
- **Java**: Instala Java latest

**`select-dev-storage.sh`** - Selección de bases de datos
Bases de datos disponibles (en Docker):
- **MySQL**: Base de datos relacional
- **PostgreSQL**: Base de datos relacional avanzada
- **Redis**: Base de datos en memoria (cache)

**`set-git.sh`** - Configuración de Git
- Configura nombre y email del usuario
- Establece configuraciones globales

### 🔹 Aplicaciones de Escritorio

Ubicación: `install/desktop/`

#### Gestores de Paquetes

**`a-flatpak.sh`** - Flatpak
- Instala Flatpak
- Añade repositorio Flathub

#### Navegadores

**`app-chrome.sh`** - Google Chrome
- Descarga e instala Chrome estable
- Añade repositorio oficial

#### Terminales

**`app-alacritty.sh`** - Alacritty
- Terminal acelerada por GPU
- Configuración en `configs/alacritty.toml`
- Soporte para temas

#### Editores

**`app-vscode.sh`** - Visual Studio Code
- Instala VSCode
- Aplica configuración personalizada
- Instala extensiones recomendadas

**`app-typora.sh`** - Typora
- Editor Markdown WYSIWYG
- Configuración de temas

#### Utilidades

**`app-flameshot.sh`** - Capturas de pantalla
- Herramienta de screenshots avanzada

**`app-gnome-sushi.sh`** - Previsualizador
- Vista previa de archivos con espacio

**`app-wl-clipboard.sh`** - Portapapeles Wayland
- Soporte de clipboard para Wayland

**`app-localsend.sh`** - Transferencia de archivos
- Compartir archivos en red local

#### Ofimática y Multimedia

**`app-libreoffice.sh`** - LibreOffice
- Suite ofimática completa

**`app-vlc.sh`** - VLC Media Player
- Reproductor multimedia

**`app-pinta.sh`** - Editor de imágenes
- Editor de imágenes simple

**`app-xournalpp.sh`** - Notas manuscritas
- Toma de notas con stylus

#### Comunicación

**`app-signal.sh`** - Signal
- Mensajería segura

#### Notas

**`app-obsidian.sh`** - Obsidian
- Gestión de conocimiento y notas

#### Aplicaciones Opcionales

Ubicación: `install/desktop/optional/`

- **1Password**: Gestor de contraseñas
- **Spotify**: Música en streaming
- **Discord**: Comunicación para gamers/comunidades
- **Zoom**: Videoconferencias
- **Dropbox**: Almacenamiento en nube
- **Brave**: Navegador centrado en privacidad
- **Cursor**: Editor de código con IA
- **GIMP**: Editor de imágenes avanzado
- **Audacity**: Editor de audio
- **OBS Studio**: Grabación y streaming
- Y más...

### 🔹 Configuración de GNOME

**`set-gnome-settings.sh`** - Configuraciones básicas
- Centrar ventanas nuevas
- Fuente monoespaciada: CaskaydiaMono Nerd Font
- Mostrar números de semana en calendario
- Desactivar sensor de luz ambiental

**`set-gnome-hotkeys.sh`** - Atajos de teclado
- Configuración de atajos personalizados
- Mejora productividad

**`set-gnome-extensions.sh`** - Extensiones GNOME
- Instala y configura extensiones útiles

**`set-gnome-theme.sh`** - Tema visual
- Aplica tema personalizado

**`set-dock.sh`** - Configuración del dock
- Posición, tamaño, aplicaciones fijadas

**`set-app-grid.sh`** - Organización de aplicaciones
- Ordena aplicaciones en el grid

**`fonts.sh`** - Instalación de fuentes
- Nerd Fonts (iconos en terminal)
- CaskaydiaMono, JetBrains Mono, etc.

### 🔹 Utilidades de Línea de Comandos

Ubicación: `bin/`

#### `devdeb`
Comando principal que abre un menú interactivo con opciones:
- **Theme**: Cambiar tema de colores
- **Font**: Cambiar fuente de terminal
- **Update**: Actualizar DevDeb
- **Install**: Instalar componentes adicionales
- **Uninstall**: Desinstalar componentes
- **Manual**: Ver manual de uso

#### Subcomandos (`bin/devdeb-sub/`)

**`theme.sh`** - Cambiar tema
- Tokyo Night
- Catppuccin
- Dracula
- Nord
- Gruvbox
- Y más...

**`font.sh`** - Cambiar fuente
- Lista de Nerd Fonts disponibles
- Aplica a Alacritty y terminal

**`font-size.sh`** - Cambiar tamaño de fuente

**`update.sh`** - Actualizar sistema
- Actualiza DevDeb desde repositorio
- Ejecuta migraciones si es necesario

**`install.sh`** - Instalador de componentes
- Permite instalar componentes individuales

**`uninstall.sh`** - Desinstalador
- Elimina componentes instalados

**`migrate.sh`** - Migraciones
- Ejecuta scripts de migración entre versiones

## 🎨 Temas Disponibles

Ubicación: `themes/`

Cada tema incluye configuraciones para:
- Alacritty (terminal)
- Neovim (editor)
- Otros editores

Temas populares:
- **Tokyo Night** (predeterminado)
- **Catppuccin** (Mocha, Latte, Frappe, Macchiato)
- **Dracula**
- **Nord**
- **Gruvbox**
- **One Dark**
- **Solarized**

## 📝 Archivos de Configuración

Ubicación: `configs/`

- **`bashrc`**: Configuración de Bash
- **`inputrc`**: Configuración de readline (autocompletado)
- **`alacritty.toml`**: Configuración de Alacritty
- **`zellij.kdl`**: Configuración de Zellij
- **`btop.conf`**: Configuración de btop
- **`fastfetch.jsonc`**: Configuración de fastfetch
- **`vscode.json`**: Configuración de VSCode
- **`ulauncher.json`**: Configuración de Ulauncher
- **`xcompose`**: Composición de caracteres especiales
- **`neovim/`**: Configuraciones de Neovim

## 🔄 Instalación Modular

### Solo Herramientas de Terminal

```bash
source ~/.local/share/devdeb/install/terminal.sh
```

### Solo Aplicaciones de Escritorio

```bash
source ~/.local/share/devdeb/install/desktop.sh
```

### Componentes Individuales

```bash
# Instalar solo Docker
source ~/.local/share/devdeb/install/terminal/docker.sh

# Instalar solo Neovim
source ~/.local/share/devdeb/install/terminal/app-neovim.sh

# Instalar solo VSCode
source ~/.local/share/devdeb/install/desktop/app-vscode.sh

# Instalar solo Chrome
source ~/.local/share/devdeb/install/desktop/app-chrome.sh
```

### Instalar Lenguaje Específico

```bash
# Instalar Ruby on Rails
mise use --global ruby@latest
mise x ruby -- gem install rails --no-document

# Instalar Node.js
mise use --global node@lts

# Instalar Python
mise use --global python@latest

# Instalar Go
mise use --global go@latest
```

### Instalar Base de Datos (Docker)

```bash
# MySQL
docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=root -p 3306:3306 mysql:latest

# PostgreSQL
docker run -d --name postgres -e POSTGRES_PASSWORD=postgres -p 5432:5432 postgres:latest

# Redis
docker run -d --name redis -p 6379:6379 redis:latest
```

## 🛠️ Comandos Útiles

### Gestión de DevDeb

```bash
# Abrir menú principal
devdeb

# Cambiar tema
devdeb theme

# Cambiar fuente
devdeb font

# Actualizar DevDeb
devdeb update

# Ver manual
devdeb manual
```

### Gestión de Versiones con Mise

```bash
# Ver versiones instaladas
mise list

# Instalar versión específica
mise use ruby@3.2.0

# Ver versiones disponibles
mise ls-remote ruby

# Actualizar todas las herramientas
mise upgrade
```

### Docker

```bash
# Ver contenedores
docker ps

# Gestión visual con lazydocker
lazydocker

# Docker Compose
docker compose up -d
```

### Git

```bash
# Gestión visual con lazygit
lazygit

# GitHub CLI
gh repo list
gh pr create
gh issue list
```

## 🐛 Solución de Problemas

### Error: "OS requirement not met"

El script original verifica Ubuntu 24.04+. Para Debian, edita:
```bash
nano ~/.local/share/devdeb/install/check-version.sh
```

Cambia la verificación de Ubuntu a Debian:
```bash
if [ "$ID" != "debian" ] || [ $(echo "$VERSION_ID >= 13" | bc) != 1 ]; then
```

### Error: Repositorios no encontrados

Algunos scripts usan repositorios de Ubuntu. Adapta las URLs:
- Cambia `ubuntu` por `debian`
- Cambia `$VERSION_CODENAME` por `trixie` o `testing`

### Error: Paquete no disponible

Algunos paquetes pueden tener nombres diferentes en Debian:
```bash
# Buscar paquete equivalente
apt search nombre_paquete

# Ver información del paquete
apt show nombre_paquete
```

### Reinstalar componente

```bash
# Eliminar configuración
rm -rf ~/.config/nombre_app

# Volver a ejecutar instalador
source ~/.local/share/devdeb/install/terminal/app-nombre.sh
```

### Revertir configuración de shell

```bash
# Restaurar bashrc original
mv ~/.bashrc.bak ~/.bashrc

# Restaurar inputrc original
mv ~/.inputrc.bak ~/.inputrc
```

## 📊 Diferencias con Ubuntu

### Repositorios

- **Ubuntu**: Usa PPAs y repositorios oficiales de Ubuntu
- **Debian**: Requiere adaptación de fuentes APT
- **Solución**: Usar repositorios upstream cuando sea posible

### Paquetes

- Algunos paquetes tienen nombres diferentes
- Versiones pueden ser más antiguas en Debian Stable
- Debian Testing/Trixie tiene versiones más recientes

### Snap vs Flatpak

- Ubuntu usa Snap por defecto
- Debian prefiere Flatpak
- Este script ya usa Flatpak

### GNOME

- Versiones de GNOME pueden diferir
- Algunas extensiones pueden no ser compatibles
- Configuraciones de gsettings pueden variar

## 📚 Estructura del Proyecto

```
devdeb/
├── README.md              # Enlace simbólico a docs/README.md
├── LICENSE
├── .gitignore
│
├── bin/                   # Comandos ejecutables
│   └── devdeb            # Comando principal interactivo
│
├── scripts/               # Scripts organizados por categoría
│   ├── core/             # Scripts principales
│   │   ├── boot.sh
│   │   ├── install.sh
│   │   └── ascii.sh
│   ├── setup/            # Configuración inicial
│   │   ├── check-version.sh
│   │   ├── first-run-choices.sh
│   │   └── identification.sh
│   ├── shell/            # Configuración de shell
│   │   ├── a-shell.sh
│   │   └── functions.sh
│   ├── tools/            # Instaladores de herramientas
│   │   ├── docker.sh
│   │   ├── mise.sh
│   │   ├── install-modern-tools.sh
│   │   └── install-starship.sh
│   ├── apps/             # Instaladores de aplicaciones
│   │   ├── app-neovim.sh
│   │   ├── install-neovim.sh
│   │   └── install-webapps.sh
│   └── dev/              # Desarrollo
│       └── select-dev-language.sh
│
├── lib/                   # Librerías compartidas
│   ├── colors.sh         # Definiciones de colores
│   ├── utils.sh          # Funciones de utilidad
│   └── validators.sh     # Funciones de validación
│
├── configs/               # Configuraciones
│   ├── bash/
│   │   └── inputrc
│   ├── zsh/
│   │   └── zshrc
│   ├── neovim/
│   │   ├── lazyvim.json
│   │   ├── theme-tokyonight.lua
│   │   ├── transparency.lua
│   │   └── snacks-animated-scrolling-off.lua
│   ├── starship.toml
│   └── templates/        # Plantillas reutilizables
│       └── webapp.desktop.template
│
├── docs/                  # Documentación organizada
│   ├── README.md         # Documentación principal
│   ├── getting-started/  # Guías iniciales
│   │   ├── INDEX.md
│   │   └── GUIA_ADAPTACION_DEBIAN.md
│   ├── guides/           # Guías de uso
│   │   ├── GUIA_WEB2APP.md
│   │   ├── GUIA_NEOVIM.md
│   │   ├── GUIA_STARSHIP.md
│   │   └── GUIA_HERRAMIENTAS_MODERNAS.md
│   ├── reference/        # Referencias técnicas
│   │   ├── CATALOGO_SCRIPTS.md
│   │   ├── DOCUMENTACION_FUNCTIONS.md
│   │   └── ANALISIS_DEPENDENCIAS.md
│   └── technical/        # Documentación técnica
│       ├── COMPATIBILIDAD_ZSH.md
│       ├── COMPATIBILIDAD_MISE.md
│       ├── MISE_ZSH.md
│       ├── CAMBIOS_NOMENCLATURA.md
│       └── RESUMEN_PROYECTO.md
│
└── examples/              # Ejemplos de uso
    └── custom-webapp.sh
```

## 🤝 Contribuir

Para adaptar más scripts a Debian:

1. **Identifica el script** a adaptar
2. **Verifica dependencias** en Debian
3. **Adapta repositorios** si es necesario
4. **Prueba en Debian 13** antes de usar
5. **Documenta cambios** en comentarios

## 📄 Licencia

Basado en DevDeb, licenciado bajo MIT License.

## 🔗 Enlaces Útiles

- **DevDeb Original**: https://devdeb.org
- **Repositorio DevDeb**: https://github.com/basecamp/devdeb
- **Mise**: https://mise.jdx.dev/
- **LazyVim**: https://www.lazyvim.org/
- **Alacritty**: https://alacritty.org/

## ✨ Características Destacadas

- ✅ Instalación con un solo comando
- ✅ Selección interactiva de componentes
- ✅ Múltiples temas y fuentes
- ✅ Configuración de GNOME optimizada
- ✅ Herramientas modernas de desarrollo
- ✅ Soporte para múltiples lenguajes
- ✅ Docker preconfigurado
- ✅ Terminal hermosa y productiva
- ✅ Editores configurados (Neovim, VSCode)
- ✅ Gestión de versiones con Mise

---

**¡Disfruta de tu nuevo entorno de desarrollo en Debian! 🚀**