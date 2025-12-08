# Guía de Instalación de Neovim + LazyVim (Independiente)

## 📋 Descripción

Esta guía explica cómo usar el script de instalación independiente de Neovim + LazyVim que NO requiere tener DevDeb instalado.

---

## 🎯 ¿Qué Instala?

### Componentes Principales

1. **Neovim Stable** - Última versión estable de Neovim
2. **LazyVim** - Distribución moderna de Neovim con plugins preconfigurados
3. **luarocks** - Gestor de paquetes para Lua
4. **tree-sitter-cli** - Parser para resaltado de sintaxis avanzado

### Configuraciones Aplicadas

1. ✅ **Tema Tokyo Night** - Tema oscuro moderno
2. ✅ **Transparencia** - Fondo transparente que coincide con el terminal
3. ✅ **Sin scroll animado** - Desactiva animaciones de scroll
4. ✅ **Números absolutos** - Desactiva números de línea relativos
5. ✅ **Neo-tree** - Explorador de archivos por defecto
6. ✅ **Lanzador de escritorio** - Icono en el menú de aplicaciones

---

## 🚀 Instalación Rápida

### Paso 1: Ejecutar el Script

```bash
cd ~/Workspace/Repositorios/Instalación/devdeb
./install-neovim.sh
```

### Paso 2: Primer Inicio

```bash
nvim
```

En el primer inicio, LazyVim descargará automáticamente todos los plugins. Esto puede tomar **2-5 minutos** dependiendo de tu conexión.

### Paso 3: Esperar y Reiniciar

1. Espera a que termine la instalación de plugins
2. Verás mensajes de progreso en la parte inferior
3. Cuando termine, cierra Neovim (`:q`)
4. Vuelve a abrir Neovim

---

## 📦 Requisitos Previos

### Obligatorios

```bash
# Verificar que están instalados
which wget tar git

# Si falta alguno, instalar:
sudo apt install wget tar git
```

### Opcionales

```bash
# Alacritty (para mejor experiencia)
sudo apt install alacritty

# Nerd Font (para iconos en terminal)
# Ver: https://www.nerdfonts.com/
```

---

## 📁 Archivos Creados

### Configuración de Neovim

```
~/.config/nvim/
├── init.lua                           # Archivo de entrada de LazyVim
├── lua/
│   ├── config/
│   │   ├── autocmds.lua              # Autocomandos
│   │   ├── keymaps.lua               # Atajos de teclado
│   │   ├── lazy.lua                  # Configuración de Lazy (gestor de plugins)
│   │   └── options.lua               # Opciones de Neovim
│   └── plugins/
│       ├── theme.lua                 # Tema Tokyo Night
│       └── snacks-animated-scrolling-off.lua  # Desactivar scroll animado
├── plugin/
│   └── after/
│       └── transparency.lua          # Configuración de transparencia
└── lazyvim.json                      # Configuración de LazyVim
```

### Lanzador de Escritorio

```
~/.local/share/applications/Neovim.desktop
```

### Archivos de Configuración en DevDeb

```
~/Workspace/Repositorios/Instalación/devdeb/configs/neovim/
├── transparency.lua                   # Config de transparencia
├── theme-tokyonight.lua              # Config de tema
├── snacks-animated-scrolling-off.lua # Config de scroll
└── lazyvim.json                      # Config de LazyVim
```

---

## 🎨 Personalización

### Cambiar Tema

Edita `~/.config/nvim/lua/plugins/theme.lua`:

```lua
return {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "catppuccin",  -- Cambiar a otro tema
		},
	},
}
```

Temas disponibles en LazyVim:
- `tokyonight` (predeterminado)
- `catppuccin`
- `dracula`
- `nord`
- `gruvbox`
- `onedark`

### Activar Números Relativos

Edita `~/.config/nvim/lua/config/options.lua`:

```lua
-- Comentar o eliminar esta línea:
-- vim.opt.relativenumber = false

-- O cambiar a true:
vim.opt.relativenumber = true
```

### Desactivar Transparencia

Elimina o renombra el archivo:

```bash
mv ~/.config/nvim/plugin/after/transparency.lua ~/.config/nvim/plugin/after/transparency.lua.bak
```

### Activar Scroll Animado

Elimina el archivo:

```bash
rm ~/.config/nvim/lua/plugins/snacks-animated-scrolling-off.lua
```

---

## ⌨️ Atajos de Teclado Principales

### Navegación

| Atajo | Acción |
|-------|--------|
| `<leader>e` | Abrir/cerrar Neo-tree (explorador) |
| `<leader>ff` | Buscar archivos (Telescope) |
| `<leader>fg` | Buscar en archivos (grep) |
| `<leader>fb` | Buscar buffers abiertos |
| `<leader>fr` | Archivos recientes |

**Nota**: `<leader>` es la tecla espacio por defecto

### Edición

| Atajo | Acción |
|-------|--------|
| `gcc` | Comentar/descomentar línea |
| `gc` (visual) | Comentar selección |
| `<leader>cf` | Formatear código |
| `<leader>cr` | Renombrar símbolo |

### Ventanas

| Atajo | Acción |
|-------|--------|
| `<C-h>` | Ir a ventana izquierda |
| `<C-j>` | Ir a ventana abajo |
| `<C-k>` | Ir a ventana arriba |
| `<C-l>` | Ir a ventana derecha |
| `<leader>-` | Split horizontal |
| `<leader>|` | Split vertical |

### Terminal

| Atajo | Acción |
|-------|--------|
| `<leader>ft` | Abrir terminal flotante |
| `<C-/>` | Toggle terminal |

---

## 🔧 Comandos Útiles

### Gestión de Plugins

```vim
:Lazy              " Abrir gestor de plugins
:Lazy update       " Actualizar todos los plugins
:Lazy sync         " Sincronizar plugins
:Lazy clean        " Limpiar plugins no usados
```

### Diagnóstico

```vim
:checkhealth       " Verificar estado de Neovim
:LazyHealth        " Verificar estado de LazyVim
:Mason             " Gestor de LSP/DAP/linters
```

### LSP (Language Server Protocol)

```vim
:LspInfo           " Información de LSP activos
:Mason             " Instalar language servers
```

---

## 🐛 Solución de Problemas

### Problema: Plugins no se instalan

**Solución**:
```bash
# Eliminar caché de Lazy
rm -rf ~/.local/share/nvim/lazy

# Volver a abrir Neovim
nvim
```

### Problema: Errores de Tree-sitter

**Solución**:
```vim
:TSUpdate          " Actualizar parsers
:TSInstall all     " Instalar todos los parsers
```

### Problema: LSP no funciona

**Solución**:
```vim
:Mason             " Abrir Mason
" Buscar e instalar el language server necesario
" Ejemplo: lua_ls, pyright, tsserver, etc.
```

### Problema: Tema no se aplica

**Solución**:
```bash
# Reinstalar tema
nvim
:Lazy sync
:colorscheme tokyonight
```

### Problema: Transparencia no funciona

**Verificar**:
1. Terminal soporta transparencia (Alacritty, Kitty, etc.)
2. Archivo `transparency.lua` existe en `~/.config/nvim/plugin/after/`
3. Reiniciar Neovim

---

## 📚 Recursos y Documentación

### Documentación Oficial

- **LazyVim**: https://www.lazyvim.org/
- **Neovim**: https://neovim.io/doc/
- **Lazy.nvim**: https://github.com/folke/lazy.nvim

### Tutoriales

- **LazyVim Starter**: https://github.com/LazyVim/starter
- **Neovim Tutorial**: `:Tutor` (dentro de Neovim)
- **LazyVim Keymaps**: https://www.lazyvim.org/keymaps

### Plugins Incluidos

LazyVim incluye muchos plugins preconfigurados:
- **Telescope**: Buscador fuzzy
- **Neo-tree**: Explorador de archivos
- **Which-key**: Muestra atajos disponibles
- **Mason**: Gestor de LSP/DAP/linters
- **Treesitter**: Resaltado de sintaxis avanzado
- **Gitsigns**: Integración con Git
- **Y muchos más...**

---

## 🔄 Actualización

### Actualizar Neovim

```bash
# Ejecutar el script de nuevo
cd ~/Workspace/Repositorios/Instalación/devdeb
./install-neovim.sh
```

### Actualizar LazyVim

```vim
:Lazy update       " Actualizar todos los plugins
:Lazy sync         " Sincronizar configuración
```

---

## 🗑️ Desinstalación

### Desinstalar Neovim

```bash
# Eliminar binario
sudo rm /usr/local/bin/nvim

# Eliminar librerías
sudo rm -rf /usr/local/lib/nvim
sudo rm -rf /usr/local/share/nvim

# Eliminar configuración
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

# Eliminar lanzador
rm ~/.local/share/applications/Neovim.desktop
```

---

## ✅ Verificación de Instalación

### Verificar Neovim

```bash
# Ver versión
nvim --version

# Debería mostrar algo como:
# NVIM v0.10.x
```

### Verificar LazyVim

```bash
# Abrir Neovim
nvim

# Ejecutar checkhealth
:checkhealth

# Verificar que no hay errores críticos
```

### Verificar Plugins

```vim
:Lazy

# Debería mostrar lista de plugins instalados
# Todos deberían estar en verde (instalados)
```

---

## 💡 Consejos

### 1. Aprende los Atajos Gradualmente

No intentes aprender todos los atajos de una vez. Usa `<leader>` y espera a que aparezca Which-key mostrando opciones disponibles.

### 2. Usa :checkhealth Regularmente

```vim
:checkhealth
```

Esto te dirá si falta algo o hay problemas.

### 3. Instala Language Servers Según Necesites

```vim
:Mason

" Busca e instala LSP para tus lenguajes:
" - lua_ls (Lua)
" - pyright (Python)
" - tsserver (TypeScript/JavaScript)
" - rust_analyzer (Rust)
" - etc.
```

### 4. Personaliza Gradualmente

No cambies todo de una vez. LazyVim funciona bien por defecto. Personaliza solo lo que realmente necesites.

### 5. Lee la Documentación

```vim
:help
:help lazy.nvim
:help lazyvim
```

---

## 🎉 Resumen

Has instalado:
- ✅ Neovim stable (última versión)
- ✅ LazyVim (distribución completa)
- ✅ Tema Tokyo Night
- ✅ Transparencia activada
- ✅ Configuración optimizada
- ✅ Lanzador de escritorio

**¡Disfruta de tu nuevo editor! 🚀**

Para empezar, simplemente ejecuta:
```bash
nvim
```

Y comienza a explorar. Presiona `<leader>` (espacio) para ver opciones disponibles.
