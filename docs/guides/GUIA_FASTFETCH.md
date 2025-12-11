# Guía de Configuración de Fastfetch

## 📋 Descripción

Fastfetch es una herramienta moderna de información del sistema, escrita en C, que muestra detalles del hardware y software de forma rápida y visualmente atractiva. Es el sucesor espiritual de `neofetch`.

---

## 🚀 Instalación

```bash
# Ejecutar script de instalación
./scripts/setup/install-fastfetch.sh
```

El script:
1. ✅ Instala Fastfetch desde repositorios
2. ✅ Genera configuración base
3. ✅ Aplica configuración personalizada
4. ✅ Crea backup de la configuración por defecto
5. ✅ Ejecuta prueba

---

## 📁 Ubicación de Archivos

```
~/.config/fastfetch/
├── config.jsonc          # Configuración activa
└── config.jsonc.backup   # Backup de configuración por defecto
```

**Configuración personalizada del proyecto:**
```
assets/fastfetch/config.jsonc
```

---

## 🎨 Explicación de la Configuración Personalizada

### Estructura General

El archivo `config.jsonc` está en formato JSON con comentarios (JSONC). Tiene dos secciones principales:

1. **`logo`** - Configuración del logo del sistema
2. **`modules`** - Módulos de información a mostrar

---

### 1. Configuración del Logo

```jsonc
"logo": {
    "type": "builtin",      // Usar logo integrado del sistema
    "height": 15,           // Altura del logo en líneas
    "width": 30,            // Ancho del logo en caracteres
    "padding": {
        "top": 5,           // Espaciado superior
        "left": 3           // Espaciado izquierdo
    }
}
```

**Qué hace:**
- Muestra el logo de tu distribución (Debian)
- Ajusta el tamaño y posición del logo
- El padding centra visualmente el logo

**Opciones de `type`:**
- `"builtin"` - Logo de la distribución detectada
- `"small"` - Logo compacto
- `"file"` - Cargar logo desde archivo
- `"none"` - Sin logo

**Cambios sugeridos:**
```jsonc
// Logo más pequeño
"height": 10,
"width": 20,

// Sin padding
"padding": {
    "top": 0,
    "left": 0
}
```

---

### 2. Módulos de Información

Los módulos se organizan en **4 secciones** con separadores visuales:

#### **Sección 1: Hardware** (Verde)

```jsonc
{
    "type": "custom",
    "format": "\u001b[90m┌──────────────────────Hardware──────────────────────┐"
},
{
    "type": "host",         // Modelo del PC
    "key": " PC",
    "keyColor": "green"
},
{
    "type": "cpu",          // Procesador
    "key": "│ ├",
    "keyColor": "green"
},
{
    "type": "gpu",          // Tarjeta gráfica
    "key": "│ ├󰍛",
    "keyColor": "green"
},
{
    "type": "memory",       // RAM
    "key": "│ ├󰍛",
    "keyColor": "green"
},
{
    "type": "disk",         // Disco
    "key": "└ └",
    "keyColor": "green"
}
```

**Qué muestra:**
- 🖥️ **Host**: Marca y modelo del PC (ej: Dell XPS 13)
- 🔧 **CPU**: Procesador (ej: Intel Core i7-1165G7)
- 🎮 **GPU**: Tarjeta gráfica (ej: Intel Iris Xe)
- 💾 **Memory**: RAM usada/total (ej: 8.2 GiB / 16.0 GiB)
- 💿 **Disk**: Espacio en disco (ej: 156 GiB / 512 GiB)

**Iconos Nerd Font:**
- `` - PC
- `` - CPU
- `󰍛` - GPU/RAM
- `` - Disco

---

#### **Sección 2: Software** (Amarillo)

```jsonc
{
    "type": "os",           // Sistema operativo
    "key": " OS",
    "keyColor": "yellow"
},
{
    "type": "kernel",       // Versión del kernel
    "key": "│ ├",
    "keyColor": "yellow"
},
{
    "type": "bios",         // Versión de BIOS/UEFI
    "key": "│ ├",
    "keyColor": "yellow"
},
{
    "type": "packages",     // Paquetes instalados
    "key": "│ ├󰏖",
    "keyColor": "yellow"
},
{
    "type": "shell",        // Shell actual
    "key": "└ └",
    "keyColor": "yellow"
}
```

**Qué muestra:**
- 🐧 **OS**: Debian 13 (Trixie)
- 🔩 **Kernel**: Linux 6.x.x
- 💻 **BIOS**: Versión del firmware
- 📦 **Packages**: Número de paquetes instalados
- 🐚 **Shell**: bash/zsh con versión

---

#### **Sección 3: Desktop Environment** (Azul)

```jsonc
{
    "type": "de",           // Entorno de escritorio
    "key": " DE",
    "keyColor": "blue"
},
{
    "type": "lm",           // Login manager
    "key": "│ ├",
    "keyColor": "blue"
},
{
    "type": "wm",           // Window manager
    "key": "│ ├",
    "keyColor": "blue"
},
{
    "type": "wmtheme",      // Tema del WM
    "key": "│ ├󰉼",
    "keyColor": "blue"
},
{
    "type": "terminal",     // Terminal actual
    "key": "└ └",
    "keyColor": "blue"
}
```

**Qué muestra:**
- 🖼️ **DE**: GNOME 45
- 🔐 **LM**: GDM (GNOME Display Manager)
- 🪟 **WM**: Mutter (GNOME's window manager)
- 🎨 **WM Theme**: Adwaita
- 💻 **Terminal**: gnome-terminal

---

#### **Sección 4: Uptime / Age / DateTime** (Magenta)

```jsonc
{
    "type": "command",      // Comando personalizado
    "key": "  OS Age ",
    "keyColor": "magenta",
    "text": "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days"
},
{
    "type": "uptime",       // Tiempo encendido
    "key": "  Uptime ",
    "keyColor": "magenta"
},
{
    "type": "datetime",     // Fecha y hora
    "key": "  DateTime ",
    "keyColor": "magenta"
}
```

**Qué muestra:**
- 📅 **OS Age**: Días desde la instalación del sistema
- ⏱️ **Uptime**: Tiempo desde el último arranque
- 🕐 **DateTime**: Fecha y hora actual

**El comando de OS Age:**
- Calcula cuántos días han pasado desde que se instaló el sistema
- Usa `stat -c %W /` para obtener la fecha de creación del sistema de archivos raíz

---

#### **Sección 5: Paleta de Colores**

```jsonc
{
    "type": "colors",
    "paddingLeft": 2,
    "symbol": "circle"
}
```

**Qué muestra:**
- Muestra los 16 colores del terminal
- Útil para verificar el esquema de colores
- Usa círculos (●) como símbolo

---

## 🎨 Personalización

### Cambiar Colores de las Secciones

```jsonc
// Cambiar color de la sección Hardware de verde a cyan
"keyColor": "cyan"
```

**Colores disponibles:**
- `"black"`, `"red"`, `"green"`, `"yellow"`
- `"blue"`, `"magenta"`, `"cyan"`, `"white"`
- También soporta códigos RGB: `"#FF5733"`

---

### Añadir Más Módulos

```jsonc
// Añadir información de batería
{
    "type": "battery",
    "key": "│ ├",
    "keyColor": "green"
},

// Añadir temperatura de CPU
{
    "type": "cpu_usage",
    "key": "│ ├",
    "keyColor": "red"
},

// Añadir IP local
{
    "type": "localip",
    "key": "│ ├󰩟",
    "keyColor": "blue"
}
```

**Módulos disponibles:**
- `battery` - Batería
- `cpu_usage` - Uso de CPU
- `gpu_usage` - Uso de GPU
- `localip` - IP local
- `publicip` - IP pública
- `wifi` - Red WiFi
- `bluetooth` - Bluetooth
- `player` - Reproductor de música
- `media` - Información de medios
- `weather` - Clima

Ver todos: `fastfetch --list-modules`

---

### Cambiar el Logo

```jsonc
// Usar logo de Debian pequeño
"logo": {
    "type": "small"
}

// Usar logo personalizado
"logo": {
    "type": "file",
    "source": "/ruta/a/logo.txt"
}

// Sin logo
"logo": {
    "type": "none"
}

// Logo específico
"logo": {
    "type": "builtin",
    "source": "arch"  // Usar logo de Arch Linux
}
```

Ver logos disponibles: `fastfetch --list-logos`

---

### Modificar Separadores

```jsonc
// Cambiar estilo de separadores
{
    "type": "custom",
    "format": "═══════════════════════════════════════"
}

// Usar caracteres diferentes
{
    "type": "custom",
    "format": "▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬"
}

// Con colores
{
    "type": "custom",
    "format": "\u001b[31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\u001b[0m"
}
```

**Códigos de color ANSI:**
- `\u001b[30m` - Negro
- `\u001b[31m` - Rojo
- `\u001b[32m` - Verde
- `\u001b[33m` - Amarillo
- `\u001b[34m` - Azul
- `\u001b[35m` - Magenta
- `\u001b[36m` - Cyan
- `\u001b[37m` - Blanco
- `\u001b[90m` - Gris (usado en la config)
- `\u001b[0m` - Reset

---

## 💡 Mejoras Sugeridas

### 1. **Añadir Información de Red**

```jsonc
// Después de la sección de Uptime, añadir:
{
    "type": "custom",
    "format": "\u001b[90m┌──────────────────────Network──────────────────────┐"
},
{
    "type": "localip",
    "key": " Local IP",
    "keyColor": "cyan"
},
{
    "type": "wifi",
    "key": "│ ├󰖩",
    "keyColor": "cyan"
},
{
    "type": "custom",
    "format": "\u001b[90m└────────────────────────────────────────────────────┘"
}
```

---

### 2. **Añadir Batería (para portátiles)**

```jsonc
// En la sección Hardware, después de memory:
{
    "type": "battery",
    "key": "│ ├",
    "keyColor": "green"
}
```

---

### 3. **Mostrar Uso de Recursos**

```jsonc
// Nueva sección después de Desktop:
{
    "type": "custom",
    "format": "\u001b[90m┌──────────────────────Resources──────────────────────┐"
},
{
    "type": "cpu_usage",
    "key": " CPU Usage",
    "keyColor": "red"
},
{
    "type": "memory",
    "key": "│ ├󰍛 RAM Usage",
    "keyColor": "red",
    "format": "{/1} / {/2} ({/3})"
},
{
    "type": "disk",
    "key": "└ └ Disk Usage",
    "keyColor": "red"
},
{
    "type": "custom",
    "format": "\u001b[90m└────────────────────────────────────────────────────┘"
}
```

---

### 4. **Formato Compacto (Sin Separadores)**

```jsonc
"modules": [
    "break",
    "os",
    "host",
    "kernel",
    "uptime",
    "packages",
    "shell",
    "de",
    "wm",
    "terminal",
    "cpu",
    "gpu",
    "memory",
    "disk",
    "break",
    {"type": "colors", "symbol": "circle"}
]
```

---

### 5. **Añadir Logo ASCII Personalizado**

Crea un archivo `~/.config/fastfetch/logo.txt`:

```
    ____             ____       __  
   / __ \___  _   __/ __ \___  / /_ 
  / / / / _ \| | / / / / / _ \/ __ \
 / /_/ /  __/| |/ / /_/ /  __/ /_/ /
/_____/\___/ |___/_____/\___/_.___/ 
```

Luego en `config.jsonc`:

```jsonc
"logo": {
    "type": "file",
    "source": "~/.config/fastfetch/logo.txt",
    "color": "blue"
}
```

---

## 🔧 Comandos Útiles

```bash
# Ejecutar Fastfetch
fastfetch

# Con logo específico
fastfetch --logo debian

# Logo pequeño
fastfetch --logo small

# Sin logo
fastfetch --logo none

# Generar nueva configuración
fastfetch --gen-config

# Listar todos los módulos disponibles
fastfetch --list-modules

# Listar todos los logos disponibles
fastfetch --list-logos

# Mostrar solo ciertos módulos
fastfetch --structure "OS:Kernel:Shell:Terminal"

# Guardar output a archivo
fastfetch > system-info.txt
```

---

## 🎯 Integración con Shell

### Bash

```bash
# Añadir al final de ~/.bashrc
fastfetch
```

### Zsh

```bash
# Añadir al final de ~/.zshrc
fastfetch
```

### Solo en sesiones interactivas

```bash
# Añadir a ~/.bashrc o ~/.zshrc
if [[ $- == *i* ]]; then
    fastfetch
fi
```

---

## 📊 Comparación con Neofetch

| Característica | Fastfetch | Neofetch |
|----------------|-----------|----------|
| Velocidad | ⚡⚡⚡ | ⚡ |
| Lenguaje | C | Bash |
| Configuración | JSON | Bash |
| Mantenimiento | Activo | Archivado |
| Módulos | 50+ | 30+ |
| Personalización | Alta | Media |

---

**¡Disfruta de Fastfetch! 🚀**
