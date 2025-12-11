# Guía de Herramientas CLI Modernas

## 🛠️ Herramientas Incluidas

DevDeb incluye instaladores para herramientas CLI modernas que mejoran la experiencia de terminal.

---

## 📥 Instalación

```bash
cd ~/Workspace/Repositorios/Instalación/devdeb
./install-modern-tools.sh
```

---

## 🔧 Herramientas

### 1. eza (Reemplazo de ls)

**Qué es**: `ls` moderno con colores e iconos

**Uso**:
```bash
ls          # Lista con detalles
lsa         # Lista todo (incluye ocultos)
lt          # Vista de árbol
lta         # Árbol completo
```

**Ventajas**:
- ✅ Colores automáticos
- ✅ Iconos de archivos
- ✅ Info de Git integrada
- ✅ Más rápido que ls

---

### 2. bat (Reemplazo de cat)

**Qué es**: `cat` con syntax highlighting

**Uso**:
```bash
cat archivo.py    # Muestra con colores
bat archivo.json  # Resaltado de sintaxis
```

**Ventajas**:
- ✅ Syntax highlighting automático
- ✅ Numeración de líneas
- ✅ Integración con Git
- ✅ Paginación automática

---

### 3. fzf (Búsqueda Fuzzy)

**Qué es**: Buscador interactivo de archivos

**Uso**:
```bash
ff              # Buscar archivo con preview
Ctrl+R          # Buscar en historial
Ctrl+T          # Buscar archivo e insertar
```

**Ventajas**:
- ✅ Búsqueda interactiva
- ✅ Preview de archivos
- ✅ Muy rápido
- ✅ Integración con bat

---

### 4. zoxide (CD Inteligente)

**Qué es**: `cd` que recuerda directorios frecuentes

**Uso**:
```bash
z proyecto      # Salta a ~/dev/mi-proyecto
z doc           # Salta a ~/Documents
zi              # Búsqueda interactiva
```

**Ventajas**:
- ✅ Aprende tus directorios
- ✅ Saltos rápidos
- ✅ No necesitas ruta completa
- ✅ Búsqueda fuzzy

---

### 5. ripgrep (Grep Rápido)

**Qué es**: `grep` ultra rápido

**Uso**:
```bash
rg "patrón"           # Buscar en directorio actual
rg "patrón" archivo   # Buscar en archivo
rg -i "patrón"        # Case-insensitive
```

**Ventajas**:
- ✅ Mucho más rápido que grep
- ✅ Respeta .gitignore
- ✅ Colores automáticos
- ✅ Búsqueda recursiva por defecto

---

### 6. fd (Find Simple)

**Qué es**: Alternativa simple a `find`

**Uso**:
```bash
fd archivo.txt        # Buscar archivo
fd -e py              # Buscar por extensión
fd -t d proyecto      # Buscar directorios
```

**Ventajas**:
- ✅ Sintaxis simple
- ✅ Más rápido que find
- ✅ Colores automáticos
- ✅ Respeta .gitignore

---

## ⚙️ Configuración

### Para Zsh

Si usas Zsh, copia la configuración de DevDeb:

```bash
cp ~/Workspace/Repositorios/Instalación/devdeb/configs/zsh/zshrc ~/.zshrc
source ~/.zshrc
```

### Para Bash

Añade a `~/.bashrc`:

```bash
# eza
alias ls='eza -lh --group-directories-first --icons=auto'

# bat
alias cat='bat --style=auto'

# fzf
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"

# zoxide
eval "$(zoxide init bash)"
alias cd='z'

# ripgrep
alias grep='rg'
```

---

## 💡 Consejos

### 1. Usa Aliases

Las herramientas ya tienen aliases configurados:
- `ls` → `eza`
- `cat` → `bat`
- `cd` → `zoxide`
- `grep` → `ripgrep`

### 2. Aprende Atajos

- `Ctrl+R`: Buscar en historial (fzf)
- `Ctrl+T`: Buscar archivo (fzf)
- `Alt+C`: Cambiar directorio (fzf)

### 3. Combina Herramientas

```bash
# Buscar y editar
rg "TODO" | fzf | xargs nvim

# Buscar y ver
fd -e md | fzf --preview 'bat {}'
```

---

## 🔧 Solución de Problemas

### Herramienta no encontrada

```bash
# Verificar instalación
which eza bat fzf zoxide rg fd

# Reinstalar
./install-modern-tools.sh
```

### Aliases no funcionan

```bash
# Recargar configuración
source ~/.zshrc  # o ~/.bashrc
```

---

## 📚 Documentación

- **eza**: https://github.com/eza-community/eza
- **bat**: https://github.com/sharkdp/bat
- **fzf**: https://github.com/junegunn/fzf
- **zoxide**: https://github.com/ajeetdsouza/zoxide
- **ripgrep**: https://github.com/BurntSushi/ripgrep
- **fd**: https://github.com/sharkdp/fd

---

**¡Disfruta de tus nuevas herramientas! 🚀**
