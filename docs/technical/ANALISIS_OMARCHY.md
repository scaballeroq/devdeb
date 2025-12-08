# Análisis de Omarchy: Componentes Útiles para DevDeb

## 📊 Resumen Ejecutivo

**Omarchy** es una distribución Linux basada en **Arch Linux** creada por DHH (el mismo creador de Omakub). Aunque está diseñada para Arch, contiene varios componentes útiles que pueden adaptarse para **DevDeb** (Debian 13 + Zsh).

---

## 🔍 Análisis General

### Características de Omarchy

| Aspecto | Detalle |
|---------|---------|
| **Sistema Base** | Arch Linux |
| **Shell** | Bash (no Zsh) |
| **Scripts** | 144 archivos .sh |
| **Entorno** | Hyprland (Wayland compositor) |
| **Prompt** | Starship |
| **Terminal** | Alacritty, Ghostty, Kitty |

### Diferencias con Omakub

| Característica | Omakub | Omarchy |
|----------------|--------|---------|
| Sistema Base | Ubuntu | Arch Linux |
| Entorno Desktop | GNOME | Hyprland |
| Gestor de Paquetes | apt | pacman |
| Shell por defecto | Bash | Bash |
| Configuración | Menos modular | Muy modular |

---

## ✅ Componentes Aprovechables para DevDeb

### 1. **Starship Prompt** ⭐⭐⭐⭐⭐

**Qué es**: Prompt moderno, rápido y personalizable para cualquier shell.

**Archivo**: `config/starship.toml`

**Compatible con**:
- ✅ Bash
- ✅ Zsh
- ✅ Fish
- ✅ PowerShell

**Configuración de Omarchy**:
```toml
add_newline = true
command_timeout = 200
format = "[$directory$git_branch$git_status]($style)$character"

[character]
error_symbol = "[✗](bold cyan)"
success_symbol = "[❯](bold cyan)"

[directory]
truncation_length = 2
truncation_symbol = "…/"
repo_root_style = "bold cyan"

[git_branch]
format = "[$branch]($style) "
style = "italic cyan"

[git_status]
format = '[$all_status]($style)'
style = "cyan"
ahead = "⇡${count} "
behind = "⇣${count} "
```

**Ventajas**:
- ✅ Muy rápido (escrito en Rust)
- ✅ Funciona en Zsh
- ✅ Muestra información de Git
- ✅ Minimalista y limpio
- ✅ Fácil de personalizar

**Recomendación**: **INCLUIR** en DevDeb

---

### 2. **Funciones de Bash** ⭐⭐⭐⭐

**Archivo**: `default/bash/functions`

**Funciones útiles**:

#### a) Compresión (Ya en DevDeb ✅)
```bash
compress() { tar -czf "${1%/}.tar.gz" "${1%/}"; }
alias decompress="tar -xzf"
```

#### b) ISO a SD (Ya en DevDeb ✅)
```bash
iso2sd() { ... }
```

#### c) **Format Drive** (NUEVO) ⭐
```bash
format-drive() {
  # Formatea un disco completo con exFAT
  # Útil para USBs y discos externos
}
```

**Ventaja**: Formatea con exFAT (compatible con Windows/Mac/Linux)

#### d) **Transcodificación de Video** (NUEVO) ⭐⭐
```bash
transcode-video-1080p() {
  ffmpeg -i $1 -vf scale=1920:1080 -c:v libx264 -preset fast -crf 23 -c:a copy ${1%.*}-1080p.mp4
}

transcode-video-4K() {
  ffmpeg -i $1 -c:v libx265 -preset slow -crf 24 -c:a aac -b:a 192k ${1%.*}-optimized.mp4
}
```

**Ventaja**: Optimiza videos para compartir online

#### e) **Transcodificación de Imágenes** (NUEVO) ⭐⭐
```bash
img2jpg() { ... }
img2jpg-small() { ... }
img2png() { ... }
```

**Ventaja**: Optimiza imágenes (reduce tamaño manteniendo calidad)

**Recomendación**: **INCLUIR** format-drive, transcoding de video/imagen

---

### 3. **Aliases Modernos** ⭐⭐⭐⭐

**Archivo**: `default/bash/aliases`

**Aliases útiles**:

#### a) **eza** (reemplazo moderno de ls)
```bash
if command -v eza &> /dev/null; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi
```

**Ventaja**: `eza` es más rápido y bonito que `ls`

#### b) **fzf** (búsqueda fuzzy)
```bash
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
```

**Ventaja**: Búsqueda interactiva de archivos con preview

#### c) **zoxide** (cd inteligente)
```bash
if command -v zoxide &> /dev/null; then
  alias cd="zd"
  zd() {
    if [ $# -eq 0 ]; then
      builtin cd ~ && return
    elif [ -d "$1" ]; then
      builtin cd "$1"
    else
      z "$@" && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
    fi
  }
fi
```

**Ventaja**: `zoxide` recuerda directorios frecuentes

#### d) **Navegación rápida**
```bash
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
```

#### e) **Git shortcuts**
```bash
alias g='git'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'
```

#### f) **Neovim inteligente**
```bash
n() { if [ "$#" -eq 0 ]; then nvim .; else nvim "$@"; fi; }
```

**Ventaja**: `n` sin argumentos abre directorio actual

**Recomendación**: **INCLUIR** todos estos aliases

---

### 4. **Inputrc Mejorado** ⭐⭐⭐⭐⭐

**Archivo**: `default/bash/inputrc`

**Mejoras importantes**:

```bash
# Búsqueda en historial con flechas
"\e[A": history-search-backward
"\e[B": history-search-forward

# Case-insensitive completion
set completion-ignore-case on

# Mostrar todas las opciones si hay ambigüedad
set show-all-if-ambiguous on

# No autocompletar archivos ocultos a menos que empieces con .
set match-hidden-files off

# Mostrar información de archivos al autocompletar
set visible-stats on

# Colores en autocompletado
set colored-stats on
```

**Ventajas**:
- ✅ Búsqueda en historial con ↑↓
- ✅ Autocompletado case-insensitive
- ✅ Autocompletado con colores
- ✅ Más inteligente

**Recomendación**: **INCLUIR** (funciona en Bash, compatible con Zsh via bindkey)

---

### 5. **Herramientas Modernas** ⭐⭐⭐

Omarchy usa herramientas CLI modernas que podríamos incluir:

| Herramienta | Reemplazo de | Ventaja |
|-------------|--------------|---------|
| **eza** | ls | Más rápido, iconos, colores |
| **bat** | cat | Syntax highlighting |
| **fzf** | grep/find | Búsqueda interactiva |
| **zoxide** | cd | CD inteligente |
| **ripgrep** | grep | Mucho más rápido |
| **fd** | find | Más rápido y simple |
| **starship** | prompt | Moderno y rápido |

**Recomendación**: **INCLUIR** script de instalación de herramientas modernas

---

## ❌ Componentes NO Aprovechables

### 1. **Hyprland** ❌
- Solo para Wayland
- Muy específico de Arch
- DevDeb usa GNOME

### 2. **Pacman Scripts** ❌
- Gestor de paquetes de Arch
- No compatible con Debian/apt

### 3. **AUR Helpers** ❌
- Específico de Arch
- No existe en Debian

---

## 📝 Recomendaciones para DevDeb

### Prioridad Alta ⭐⭐⭐⭐⭐

1. **Starship Prompt**
   - Crear script `install-starship.sh`
   - Incluir configuración de omarchy
   - Compatible con Zsh

2. **Inputrc Mejorado**
   - Copiar configuración de omarchy
   - Añadir a `a-shell.sh` o crear `a-shell-zsh.sh`

3. **Aliases Modernos**
   - Añadir a `functions.sh`
   - Incluir detección de herramientas (eza, zoxide, etc.)

### Prioridad Media ⭐⭐⭐

4. **Funciones de Transcodificación**
   - Añadir a `functions.sh`
   - Útil para usuarios que trabajan con media

5. **Script de Herramientas Modernas**
   - Crear `install-modern-tools.sh`
   - Instalar: eza, bat, fzf, zoxide, ripgrep, fd

### Prioridad Baja ⭐⭐

6. **Format Drive Function**
   - Añadir a `functions.sh`
   - Útil pero no esencial

---

## 🎯 Plan de Implementación

### Fase 1: Starship (Inmediato)

```bash
# Crear install-starship.sh
# 1. Instalar starship
# 2. Copiar config de omarchy
# 3. Añadir a ~/.zshrc o ~/.bashrc
```

### Fase 2: Aliases y Functions (Corto Plazo)

```bash
# Actualizar functions.sh
# 1. Añadir funciones de transcodificación
# 2. Añadir format-drive
# 3. Añadir aliases modernos
# 4. Detectar herramientas instaladas
```

### Fase 3: Herramientas Modernas (Medio Plazo)

```bash
# Crear install-modern-tools.sh
# Instalar: eza, bat, fzf, zoxide, ripgrep, fd, starship
```

### Fase 4: Inputrc (Opcional)

```bash
# Crear configs/bash/inputrc
# Copiar configuración de omarchy
# Añadir a a-shell.sh
```

---

## 📊 Tabla Comparativa

| Componente | Omakub | Omarchy | DevDeb Actual | Recomendación |
|------------|--------|---------|---------------|---------------|
| Prompt | Bash default | Starship | Bash default | ✅ Añadir Starship |
| ls | ls | eza | ls | ✅ Añadir eza |
| cat | cat | bat | cat | ✅ Añadir bat |
| cd | cd | zoxide | cd | ✅ Añadir zoxide |
| find | find | fd | find | ✅ Añadir fd |
| grep | grep | ripgrep | grep | ✅ Añadir ripgrep |
| Inputrc | Básico | Mejorado | Básico | ✅ Mejorar |
| Aliases | Básicos | Modernos | Básicos | ✅ Añadir |
| Functions | Básicas | + Media | Básicas | ✅ Añadir media |

---

## ✅ Conclusión

### Resumen

Omarchy tiene **muchos componentes útiles** que pueden adaptarse a DevDeb:

1. ✅ **Starship** - Prompt moderno (compatible Zsh)
2. ✅ **Aliases modernos** - Mejoran productividad
3. ✅ **Functions de media** - Útiles para transcodificación
4. ✅ **Inputrc mejorado** - Mejor experiencia de terminal
5. ✅ **Herramientas CLI modernas** - eza, bat, fzf, zoxide

### Próximos Pasos

1. Crear `install-starship.sh`
2. Actualizar `functions.sh` con nuevas funciones
3. Crear `install-modern-tools.sh`
4. Documentar todo en español

### Compatibilidad con Zsh

**Buenas noticias**: Todos los componentes recomendados son **compatibles con Zsh**:
- ✅ Starship funciona en Zsh
- ✅ Aliases funcionan en Zsh
- ✅ Functions funcionan en Zsh
- ✅ Herramientas CLI funcionan en cualquier shell

---

*Análisis realizado: 2025-12-08*
