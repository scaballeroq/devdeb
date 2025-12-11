# Guía de Starship Prompt

## 🚀 ¿Qué es Starship?

**Starship** es un prompt minimalista, rápido y altamente personalizable para cualquier shell.

### Características

- ⚡ **Rápido**: Escrito en Rust
- 🎨 **Personalizable**: Configuración en TOML
- 🔌 **Universal**: Funciona en Bash, Zsh, Fish, PowerShell
- 📊 **Informativo**: Muestra Git, lenguajes, etc.
- 🎯 **Inteligente**: Solo muestra info relevante

---

## 📥 Instalación

```bash
cd ~/Workspace/Repositorios/Instalación/devdeb
./install-starship.sh
```

El script:
1. Instala Starship
2. Copia configuración de DevDeb
3. Activa en tu shell (Bash o Zsh)
4. Verifica Nerd Fonts

---

## ⚙️ Configuración

### Archivo de Configuración

`~/.config/starship.toml`

### Configuración de DevDeb

```toml
# Prompt minimalista
format = "[$directory$git_branch$git_status]($style)$character"

# Símbolos
[character]
success_symbol = "[❯](bold cyan)"
error_symbol = "[✗](bold cyan)"

# Git
[git_branch]
format = "[$branch]($style) "
style = "italic cyan"
```

---

## 🎨 Personalización

### Cambiar Colores

```toml
[character]
success_symbol = "[❯](bold green)"  # Verde en lugar de cyan
```

### Añadir Información

```toml
# Añadir tiempo de ejecución
format = "[$directory$git_branch$git_status$cmd_duration]($style)$character"

[cmd_duration]
min_time = 500
format = "[$duration]($style) "
```

### Más Módulos

Ver: https://starship.rs/config/

---

## 💡 Uso

### Información Mostrada

- 📁 **Directorio actual** (truncado inteligentemente)
- 🌿 **Rama de Git** (si estás en un repo)
- 📊 **Estado de Git** (cambios, commits adelante/atrás)
- ❯ **Símbolo** (cyan si OK, rojo si error)

### Comandos Útiles

```bash
# Ver versión
starship --version

# Abrir configuración
starship config

# Explicar elementos del prompt
starship explain

# Ver configuración actual
starship print-config
```

---

## 🔧 Solución de Problemas

### Prompt no aparece

```bash
# Verificar que está en el archivo de configuración
grep starship ~/.zshrc  # o ~/.bashrc

# Debería mostrar:
# eval "$(starship init zsh)"
```

### Iconos no se ven

Instala una Nerd Font:
1. https://www.nerdfonts.com/
2. Descarga FiraCode Nerd Font
3. Instala en tu sistema
4. Configura terminal para usarla

### Prompt muy lento

```toml
# Reducir timeout
command_timeout = 100  # Default: 500
```

---

## 📚 Recursos

- **Sitio oficial**: https://starship.rs/
- **Configuración**: https://starship.rs/config/
- **Presets**: https://starship.rs/presets/

---

## ✅ Verificación

```bash
# Ver versión
starship --version

# Debería mostrar algo como:
# starship 1.x.x
```

---

**¡Disfruta de tu nuevo prompt! 🚀**
