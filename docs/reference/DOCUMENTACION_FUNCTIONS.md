# Documentación de functions.sh

## 📋 Descripción General

El archivo `functions.sh` contiene todas las funciones de Bash necesarias para el proyecto DevDeb, especialmente para crear y gestionar webapps con `web2app`.

**Ubicación**: `/home/caballero/Workspace/Repositorios/Instalación/devdeb/functions.sh`

---

## 🎯 Propósito

Este archivo proporciona funciones independientes que NO requieren tener Omakub instalado. Es una versión adaptada y documentada de las funciones de Omakub, lista para usar en Debian.

---

## 📦 Funciones Incluidas

### 1. Funciones de Compresión

#### `compress`
**Propósito**: Comprimir un directorio en archivo `.tar.gz`

**Uso**:
```bash
compress nombre_directorio
```

**Resultado**: Crea `nombre_directorio.tar.gz`

**Ejemplo**:
```bash
compress mi_proyecto
# Crea: mi_proyecto.tar.gz
```

**Cómo funciona**:
1. Toma el nombre del directorio
2. Elimina la barra final si existe (`${1%/}`)
3. Usa `tar -czf` para comprimir:
   - `-c`: Crear archivo
   - `-z`: Comprimir con gzip
   - `-f`: Especificar nombre de archivo

---

#### `decompress`
**Propósito**: Descomprimir archivo `.tar.gz`

**Uso**:
```bash
decompress archivo.tar.gz
```

**Nota**: Es un alias de `tar -xzf`

**Ejemplo**:
```bash
decompress mi_proyecto.tar.gz
# Extrae el contenido del archivo
```

---

### 2. Funciones de Conversión de Medios

#### `webm2mp4`
**Propósito**: Convertir videos WebM (generados por grabadora de GNOME) a MP4

**Uso**:
```bash
webm2mp4 archivo.webm
```

**Resultado**: Crea `archivo.mp4`

**Requisitos**: `ffmpeg` instalado

**Ejemplo**:
```bash
webm2mp4 screencast.webm
# Crea: screencast.mp4
```

**Cómo funciona**:
1. Verifica que se pasó un archivo
2. Verifica que ffmpeg está instalado
3. Genera nombre de salida (cambia .webm por .mp4)
4. Convierte usando ffmpeg con parámetros optimizados:
   - Codec de video: H.264 (libx264)
   - Preset: slow (mejor compresión)
   - CRF: 22 (calidad alta)
   - Codec de audio: AAC
   - Bitrate de audio: 192 kbps

**Instalar ffmpeg**:
```bash
sudo apt install ffmpeg
```

---

### 3. Funciones de Utilidades de Sistema

#### `iso2sd`
**Propósito**: Escribir archivo ISO a tarjeta SD/USB (crear USB bootable)

**Uso**:
```bash
iso2sd archivo.iso /dev/sdX
```

**⚠️ ADVERTENCIA**: Esto borrará TODOS los datos en el dispositivo

**Ejemplo**:
```bash
# Ver dispositivos disponibles
iso2sd

# Escribir ISO
iso2sd ~/Downloads/debian-13-amd64.iso /dev/sdb
```

**Cómo funciona**:
1. Si no se pasan argumentos, muestra dispositivos disponibles
2. Si se pasan 2 argumentos:
   - Usa `dd` para escribir ISO al dispositivo
   - `bs=4M`: Tamaño de bloque de 4MB (más rápido)
   - `status=progress`: Muestra progreso
   - `oflag=sync`: Sincroniza después de cada escritura
3. Expulsa el dispositivo de forma segura con `eject`

---

### 4. Funciones de WebApps ⭐

#### `web2app`
**Propósito**: Crear una aplicación de escritorio desde un sitio web

**Uso**:
```bash
web2app 'NombreApp' URL URLIcono
```

**Parámetros**:
- `NombreApp`: Nombre de la aplicación (entre comillas si tiene espacios)
- `URL`: URL completa del sitio web
- `URLIcono`: URL del icono en formato PNG

**Requisitos**: Google Chrome instalado

**Ejemplo**:
```bash
web2app 'Gmail' https://mail.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/gmail.png
```

**Archivos creados**:
- `~/.local/share/applications/NombreApp.desktop` - Lanzador
- `~/.local/share/applications/icons/NombreApp.png` - Icono

**Cómo funciona paso a paso**:

1. **Verificación de argumentos**:
   ```bash
   if [ "$#" -ne 3 ]; then
     # Mostrar mensaje de uso
     return 1
   fi
   ```
   - Verifica que se pasaron exactamente 3 argumentos
   - Si no, muestra ayuda y sale

2. **Verificación de Chrome**:
   ```bash
   if ! command -v google-chrome &> /dev/null; then
     # Mostrar error
     return 1
   fi
   ```
   - Verifica que Google Chrome está instalado
   - Si no, muestra mensaje de error con instrucciones

3. **Asignación de variables**:
   ```bash
   local APP_NAME="$1"
   local APP_URL="$2"
   local ICON_URL="$3"
   local ICON_DIR="$HOME/.local/share/applications/icons"
   local DESKTOP_FILE="$HOME/.local/share/applications/${APP_NAME}.desktop"
   local ICON_PATH="${ICON_DIR}/${APP_NAME}.png"
   ```
   - Asigna parámetros a variables con nombres descriptivos
   - Define rutas de archivos

4. **Creación de directorio de iconos**:
   ```bash
   mkdir -p "$ICON_DIR"
   ```
   - Crea el directorio si no existe
   - `-p`: No da error si ya existe

5. **Descarga del icono**:
   ```bash
   if ! curl -sL -o "$ICON_PATH" "$ICON_URL"; then
     echo "Error: No se pudo descargar el icono"
     return 1
   fi
   ```
   - Descarga el icono con `curl`
   - `-s`: Silencioso
   - `-L`: Seguir redirecciones
   - `-o`: Guardar en archivo
   - Verifica que la descarga fue exitosa

6. **Verificación del icono**:
   ```bash
   if ! file "$ICON_PATH" | grep -q "PNG image"; then
     echo "Advertencia: No parece ser PNG válido"
   fi
   ```
   - Verifica que el archivo es realmente PNG
   - Muestra advertencia si no lo es

7. **Creación del archivo .desktop**:
   ```bash
   cat > "$DESKTOP_FILE" <<EOF
   [Desktop Entry]
   Version=1.0
   Name=$APP_NAME
   Comment=$APP_NAME
   Exec=google-chrome --app="$APP_URL" --name="$APP_NAME" --class="$APP_NAME" --window-size=800,600
   Terminal=false
   Type=Application
   Icon=$ICON_PATH
   Categories=GTK;
   MimeType=text/html;text/xml;application/xhtml_xml;
   StartupNotify=true
   EOF
   ```
   - Crea archivo .desktop con configuración
   - **Parámetros de Chrome**:
     - `--app="URL"`: Modo aplicación (sin barras)
     - `--name="NombreApp"`: Nombre de ventana
     - `--class="NombreApp"`: Clase de ventana
     - `--window-size=800,600`: Tamaño inicial

8. **Hacer ejecutable**:
   ```bash
   chmod +x "$DESKTOP_FILE"
   ```
   - Da permisos de ejecución al archivo .desktop

9. **Actualizar base de datos**:
   ```bash
   if command -v update-desktop-database &> /dev/null; then
     update-desktop-database "$HOME/.local/share/applications/" 2>/dev/null
   fi
   ```
   - Actualiza la caché de aplicaciones
   - Hace que la app aparezca inmediatamente en el menú

10. **Mensaje de éxito**:
    ```bash
    echo "✅ WebApp '$APP_NAME' creada correctamente"
    echo "   Lanzador: $DESKTOP_FILE"
    echo "   Icono: $ICON_PATH"
    ```
    - Muestra confirmación con rutas de archivos

---

#### `web2app-remove`
**Propósito**: Eliminar una webapp creada con web2app

**Uso**:
```bash
web2app-remove 'NombreApp'
```

**Ejemplo**:
```bash
web2app-remove 'Gmail'
```

**Cómo funciona**:

1. **Verificación de argumentos**:
   - Verifica que se pasó el nombre de la app

2. **Verificación de existencia**:
   ```bash
   if [ ! -f "$DESKTOP_FILE" ]; then
     echo "Error: La webapp no existe"
     return 1
   fi
   ```
   - Verifica que el archivo .desktop existe

3. **Eliminación de archivos**:
   ```bash
   rm "$DESKTOP_FILE"
   if [ -f "$ICON_PATH" ]; then
     rm "$ICON_PATH"
   fi
   ```
   - Elimina archivo .desktop
   - Elimina icono si existe

4. **Actualización de base de datos**:
   - Actualiza la caché de aplicaciones

---

### 5. Funciones de Organización de Aplicaciones en GNOME

#### `app2folder`
**Propósito**: Añadir una aplicación a una carpeta en el grid de GNOME

**Uso**:
```bash
app2folder 'archivo.desktop' NombreCarpeta
```

**Ejemplo**:
```bash
app2folder 'Gmail.desktop' WebApps
```

**Requisitos**: GNOME como entorno de escritorio

**Cómo funciona**:

1. **Verificación de argumentos y entorno**:
   ```bash
   if [ "$XDG_CURRENT_DESKTOP" != "GNOME" ]; then
     echo "Advertencia: Solo funciona en GNOME"
     return 1
   fi
   ```
   - Verifica que estamos en GNOME

2. **Construcción del schema**:
   ```bash
   local SCHEMA="org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/$FOLDER/"
   ```
   - Construye la ruta de gsettings para la carpeta

3. **Verificación/Creación de carpeta**:
   ```bash
   if [ -z "$CURRENT_APPS" ]; then
     # Crear carpeta
     gsettings set org.gnome.desktop.app-folders folder-children "['$FOLDER']"
     gsettings set "$SCHEMA" name "$FOLDER"
   fi
   ```
   - Si la carpeta no existe, la crea

4. **Verificación de duplicados**:
   ```bash
   if [[ "$CURRENT_APPS" == *"$DESKTOP_FILE"* ]]; then
     echo "La aplicación ya está en la carpeta"
     return 0
   fi
   ```
   - Verifica que la app no esté ya en la carpeta

5. **Añadir aplicación**:
   ```bash
   local TRIMMED=$(echo "$CURRENT_APPS" | sed "s/^\[//;s/\]$//")
   gsettings set "$SCHEMA" apps "[$TRIMMED, '$DESKTOP_FILE']"
   ```
   - Añade la app a la lista de apps de la carpeta

---

#### `app2folder-remove`
**Propósito**: Eliminar una aplicación de una carpeta de GNOME

**Uso**:
```bash
app2folder-remove 'archivo.desktop' NombreCarpeta
```

**Ejemplo**:
```bash
app2folder-remove 'Gmail.desktop' WebApps
```

**Cómo funciona**:

1. Obtiene lista actual de apps en la carpeta
2. Verifica que la app está en la carpeta
3. Filtra la app de la lista
4. Actualiza gsettings con la nueva lista

---

### 6. Aliases Útiles

#### `fix_fkeys`
**Propósito**: Configurar teclados externos para usar teclas F por defecto

**Uso**:
```bash
fix_fkeys
```

**Para qué sirve**: Algunos teclados (especialmente Apple y mecánicos) usan las teclas F para funciones multimedia por defecto. Este comando las configura para que sean teclas F normales.

---

#### `fix_spotify_window_size`
**Propósito**: Arreglar tamaño de ventana de Spotify (demasiado grande)

**Uso**:
```bash
fix_spotify_window_size
```

**Qué hace**: Reduce el zoom de Spotify a 1.5x para que quepa mejor en pantallas pequeñas.

---

## 🚀 Cómo Usar functions.sh

### Opción 1: Cargar Manualmente (Temporal)

```bash
# Cargar funciones en la sesión actual
source ~/Workspace/Repositorios/Instalación/devdeb/functions.sh

# Ahora puedes usar las funciones
web2app 'Gmail' https://mail.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/gmail.png
```

### Opción 2: Cargar Automáticamente (Permanente)

Añadir a `~/.bashrc`:

```bash
# Editar bashrc
nano ~/.bashrc

# Añadir al final:
source ~/Workspace/Repositorios/Instalación/devdeb/functions.sh

# Recargar bashrc
source ~/.bashrc
```

### Opción 3: Usar en Scripts

```bash
#!/bin/bash

# Cargar funciones al inicio del script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/functions.sh"

# Usar funciones
web2app 'YouTube' https://youtube.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/youtube.png
```

---

## 📝 Ejemplos Prácticos

### Crear una WebApp

```bash
# Cargar funciones
source ~/Workspace/Repositorios/Instalación/devdeb/functions.sh

# Crear webapp de Gmail
web2app 'Gmail' https://mail.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/gmail.png

# Añadir a carpeta WebApps
app2folder 'Gmail.desktop' WebApps
```

### Crear Múltiples WebApps

```bash
# Cargar funciones
source ~/Workspace/Repositorios/Instalación/devdeb/functions.sh

# Google Workspace
web2app 'Gmail' https://mail.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/gmail.png
web2app 'Google Calendar' https://calendar.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-calendar.png
web2app 'Google Drive' https://drive.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-drive.png

# Organizar en carpeta
app2folder 'Gmail.desktop' WebApps
app2folder 'Google Calendar.desktop' WebApps
app2folder 'Google Drive.desktop' WebApps
```

### Eliminar WebApp

```bash
# Eliminar de carpeta primero (opcional)
app2folder-remove 'Gmail.desktop' WebApps

# Eliminar webapp
web2app-remove 'Gmail'
```

---

## 🔍 Verificación de Instalación

### Verificar que las funciones están cargadas

```bash
# Ver si web2app está disponible
type web2app

# Debería mostrar:
# web2app is a function
```

### Listar funciones disponibles

```bash
# Ver todas las funciones definidas
declare -F | grep -E '(web2app|app2folder|compress)'
```

### Verificar WebApps instaladas

```bash
# Ver lanzadores creados
ls ~/.local/share/applications/*.desktop

# Ver iconos descargados
ls ~/.local/share/applications/icons/
```

---

## 🐛 Solución de Problemas

### Error: "command not found: web2app"

**Causa**: Las funciones no están cargadas

**Solución**:
```bash
source ~/Workspace/Repositorios/Instalación/devdeb/functions.sh
```

### Error: "Google Chrome no está instalado"

**Causa**: Chrome no está instalado

**Solución**:
```bash
# Descargar e instalar Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f
```

### Error: "Failed to download icon"

**Causas posibles**:
1. URL del icono incorrecta
2. Sin conexión a internet
3. Icono no existe en esa URL

**Solución**:
```bash
# Probar descargar manualmente
curl -I https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/gmail.png

# Buscar icono alternativo en:
# https://dashboardicons.com
```

### La webapp no aparece en el menú

**Solución**:
```bash
# Actualizar base de datos de aplicaciones
update-desktop-database ~/.local/share/applications/

# Reiniciar GNOME Shell (Alt+F2, escribir 'r', Enter)
```

---

## 📚 Referencias

- **Desktop Entry Specification**: https://specifications.freedesktop.org/desktop-entry-spec/latest/
- **Chrome App Mode**: https://developer.chrome.com/docs/apps/
- **Dashboard Icons**: https://dashboardicons.com
- **gsettings**: https://wiki.gnome.org/Projects/dconf

---

## ✅ Resumen

El archivo `functions.sh` proporciona:

1. ✅ **Funciones de compresión** (compress, decompress)
2. ✅ **Conversión de medios** (webm2mp4)
3. ✅ **Utilidades de sistema** (iso2sd)
4. ✅ **Creación de webapps** (web2app, web2app-remove)
5. ✅ **Organización de apps** (app2folder, app2folder-remove)
6. ✅ **Aliases útiles** (fix_fkeys, fix_spotify_window_size)

Todo completamente documentado en español y listo para usar en Debian 13 Trixie.
