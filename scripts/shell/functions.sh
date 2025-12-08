#!/bin/bash

################################################################################
# FUNCTIONS.SH - Funciones de Bash para DevDeb
################################################################################
# Descripción:
#   Este archivo contiene funciones útiles de Bash para el proyecto DevDeb.
#   Incluye las funciones web2app y app2folder necesarias para crear webapps.
#
# Uso:
#   source /ruta/a/functions.sh
#   
#   O añadir a ~/.bashrc:
#   source ~/Workspace/Repositorios/Instalación/devdeb/functions.sh
#
# Funciones incluidas:
#   - compress: Comprimir directorios en .tar.gz
#   - decompress: Descomprimir archivos .tar.gz
#   - web2app: Crear webapp desde sitio web
#   - web2app-remove: Eliminar webapp
#   - app2folder: Añadir app a carpeta de GNOME
#   - app2folder-remove: Eliminar app de carpeta de GNOME
#   - webm2mp4: Convertir videos webm a mp4
#   - iso2sd: Escribir ISO a tarjeta SD
#
# Autor:
################################################################################

################################################################################
# FUNCIONES DE COMPRESIÓN
################################################################################

# Comprimir un directorio en archivo .tar.gz
# Uso: compress nombre_directorio
# Resultado: nombre_directorio.tar.gz
compress() { 
  tar -czf "${1%/}.tar.gz" "${1%/}"
}

# Descomprimir archivo .tar.gz
# Uso: decompress archivo.tar.gz
alias decompress="tar -xzf"

################################################################################
# FUNCIONES DE CONVERSIÓN DE MEDIOS
################################################################################

# Convertir archivos webm (generados por grabadora de GNOME) a mp4
# Los mp4 son más compatibles con reproductores y editores
# Uso: webm2mp4 archivo.webm
# Resultado: archivo.mp4
# Requiere: ffmpeg instalado
webm2mp4() {
  # Verificar que se pasó un archivo
  if [ $# -ne 1 ]; then
    echo "Uso: webm2mp4 <archivo.webm>"
    return 1
  fi

  # Verificar que ffmpeg está instalado
  if ! command -v ffmpeg &> /dev/null; then
    echo "Error: ffmpeg no está instalado"
    echo "Instalar con: sudo apt install ffmpeg"
    return 1
  fi

  # Obtener nombre del archivo de entrada
  input_file="$1"
  
  # Generar nombre del archivo de salida (cambiar .webm por .mp4)
  output_file="${input_file%.webm}.mp4"
  
  # Convertir usando ffmpeg
  # -c:v libx264: Codec de video H.264
  # -preset slow: Mejor compresión (más lento)
  # -crf 22: Calidad (0-51, menor = mejor calidad)
  # -c:a aac: Codec de audio AAC
  # -b:a 192k: Bitrate de audio 192 kbps
  ffmpeg -i "$input_file" -c:v libx264 -preset slow -crf 22 -c:a aac -b:a 192k "$output_file"
}

################################################################################
# FUNCIONES DE UTILIDADES DE SISTEMA
################################################################################

# Escribir archivo ISO a tarjeta SD
# Útil para crear USBs bootables
# Uso: iso2sd archivo.iso /dev/sdX
# ADVERTENCIA: Esto borrará todos los datos en la tarjeta SD
iso2sd() {
  # Verificar que se pasaron 2 argumentos
  if [ $# -ne 2 ]; then
    echo "Uso: iso2sd <archivo_iso> <dispositivo_salida>"
    echo "Ejemplo: iso2sd ~/Downloads/debian-13-amd64.iso /dev/sda"
    echo -e "\nTarjetas SD disponibles:"
    # Listar dispositivos que parecen tarjetas SD
    lsblk -d -o NAME | grep -E '^sd[a-z]' | awk '{print "/dev/"$1}'
    return 1
  else
    # Escribir ISO a dispositivo usando dd
    # bs=4M: Tamaño de bloque de 4 megabytes (más rápido)
    # status=progress: Mostrar progreso
    # oflag=sync: Sincronizar después de cada escritura
    # if: Archivo de entrada (ISO)
    # of: Archivo de salida (dispositivo)
    sudo dd bs=4M status=progress oflag=sync if="$1" of="$2"
    
    # Expulsar el dispositivo de forma segura
    sudo eject $2
  fi
}

################################################################################
# FUNCIONES DE WEBAPPS
################################################################################

# Crear un lanzador de escritorio para una aplicación web
# Convierte cualquier sitio web en una "aplicación" que se abre en Chrome
# sin barras de navegación, como si fuera una app nativa
#
# Uso: web2app 'NombreApp' URL URLIcono
# 
# Parámetros:
#   NombreApp: Nombre de la aplicación (entre comillas si tiene espacios)
#   URL: URL completa del sitio web
#   URLIcono: URL del icono en formato PNG
#
# Ejemplo:
#   web2app 'Gmail' https://mail.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/gmail.png
#
# Archivos creados:
#   ~/.local/share/applications/NombreApp.desktop
#   ~/.local/share/applications/icons/NombreApp.png
#
# Requiere: Google Chrome instalado
web2app() {
  # Verificar que se pasaron exactamente 3 argumentos
  if [ "$#" -ne 3 ]; then
    echo "Uso: web2app <NombreApp> <URL> <URLIcono>"
    echo ""
    echo "El icono debe ser PNG. Busca iconos en:"
    echo "  https://dashboardicons.com"
    echo ""
    echo "Ejemplo:"
    echo "  web2app 'Gmail' https://mail.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/gmail.png"
    return 1
  fi

  # Verificar que Chrome está instalado
  if ! command -v google-chrome &> /dev/null; then
    echo "Error: Google Chrome no está instalado"
    echo "La función web2app requiere Google Chrome para funcionar"
    echo ""
    echo "Instalar Chrome:"
    echo "  1. Descargar: https://www.google.com/chrome/"
    echo "  2. O instalar con:"
    echo "     wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
    echo "     sudo dpkg -i google-chrome-stable_current_amd64.deb"
    echo "     sudo apt-get install -f"
    return 1
  fi

  # Asignar parámetros a variables con nombres descriptivos
  local APP_NAME="$1"      # Nombre de la aplicación
  local APP_URL="$2"       # URL del sitio web
  local ICON_URL="$3"      # URL del icono PNG
  
  # Definir rutas de archivos
  local ICON_DIR="$HOME/.local/share/applications/icons"           # Directorio para iconos
  local DESKTOP_FILE="$HOME/.local/share/applications/${APP_NAME}.desktop"  # Archivo .desktop
  local ICON_PATH="${ICON_DIR}/${APP_NAME}.png"                    # Ruta completa del icono

  # Crear directorio de iconos si no existe
  mkdir -p "$ICON_DIR"

  # Descargar el icono desde la URL proporcionada
  echo "📥 Descargando icono para $APP_NAME..."
  if ! curl -sL -o "$ICON_PATH" "$ICON_URL"; then
    echo "❌ Error: No se pudo descargar el icono desde $ICON_URL"
    echo "   Verifica que la URL sea correcta y accesible"
    return 1
  fi

  # Verificar que el archivo descargado es realmente una imagen PNG
  if ! file "$ICON_PATH" | grep -q "PNG image"; then
    echo "⚠️  Advertencia: El archivo descargado no parece ser una imagen PNG válida"
    echo "   La aplicación puede no mostrar el icono correctamente"
  fi

  # Crear el archivo .desktop con la configuración de la webapp
  echo "📝 Creando lanzador de escritorio..."
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

  # Hacer el archivo .desktop ejecutable
  chmod +x "$DESKTOP_FILE"

  # Actualizar la base de datos de aplicaciones de escritorio
  # Esto hace que la aplicación aparezca inmediatamente en el menú
  if command -v update-desktop-database &> /dev/null; then
    update-desktop-database "$HOME/.local/share/applications/" 2>/dev/null
  fi

  echo "✅ WebApp '$APP_NAME' creada correctamente"
  echo "   Lanzador: $DESKTOP_FILE"
  echo "   Icono: $ICON_PATH"
  echo ""
  echo "💡 Busca '$APP_NAME' en el menú de aplicaciones de GNOME"
}

# Eliminar una webapp creada con web2app
# Elimina tanto el archivo .desktop como el icono
#
# Uso: web2app-remove 'NombreApp'
#
# Ejemplo:
#   web2app-remove 'Gmail'
web2app-remove() {
  # Verificar que se pasó exactamente 1 argumento
  if [ "$#" -ne 1 ]; then
    echo "Uso: web2app-remove <NombreApp>"
    echo ""
    echo "Ejemplo:"
    echo "  web2app-remove 'Gmail'"
    return 1
  fi

  # Asignar parámetro a variable
  local APP_NAME="$1"
  
  # Definir rutas de archivos
  local ICON_DIR="$HOME/.local/share/applications/icons"
  local DESKTOP_FILE="$HOME/.local/share/applications/${APP_NAME}.desktop"
  local ICON_PATH="${ICON_DIR}/${APP_NAME}.png"

  # Verificar que el archivo .desktop existe
  if [ ! -f "$DESKTOP_FILE" ]; then
    echo "❌ Error: La webapp '$APP_NAME' no existe"
    echo "   No se encontró: $DESKTOP_FILE"
    return 1
  fi

  # Eliminar archivo .desktop
  echo "🗑️  Eliminando lanzador de escritorio..."
  rm "$DESKTOP_FILE"

  # Eliminar icono si existe
  if [ -f "$ICON_PATH" ]; then
    echo "🗑️  Eliminando icono..."
    rm "$ICON_PATH"
  fi

  # Actualizar base de datos de aplicaciones
  if command -v update-desktop-database &> /dev/null; then
    update-desktop-database "$HOME/.local/share/applications/" 2>/dev/null
  fi

  echo "✅ WebApp '$APP_NAME' eliminada correctamente"
}

################################################################################
# FUNCIONES DE ORGANIZACIÓN DE APLICACIONES EN GNOME
################################################################################

# Mover una aplicación a una carpeta en el grid de aplicaciones de GNOME
# Esto organiza las aplicaciones en el menú de aplicaciones
#
# Uso: app2folder archivo.desktop NombreCarpeta
#
# Ejemplo:
#   app2folder 'Gmail.desktop' WebApps
#
# Nota: El archivo .desktop debe estar en ~/.local/share/applications/
#       o en /usr/share/applications/
app2folder() {
  # Verificar que se pasaron exactamente 2 argumentos
  if [ "$#" -ne 2 ]; then
    # Mostrar carpetas existentes para ayudar al usuario
    local FOLDERS=$(gsettings get org.gnome.desktop.app-folders folder-children 2>/dev/null | tr -d "[],'")
    echo "Uso: app2folder <archivo.desktop> <nombre_carpeta>"
    echo ""
    if [ -n "$FOLDERS" ]; then
      echo "Carpetas existentes: $FOLDERS"
    else
      echo "No hay carpetas configuradas aún"
    fi
    echo ""
    echo "Ejemplo:"
    echo "  app2folder 'Gmail.desktop' WebApps"
    return 1
  fi

  # Verificar que estamos en GNOME
  if [ "$XDG_CURRENT_DESKTOP" != "GNOME" ]; then
    echo "⚠️  Advertencia: Esta función solo funciona en GNOME"
    echo "   Entorno actual: $XDG_CURRENT_DESKTOP"
    return 1
  fi

  # Asignar parámetros a variables
  local DESKTOP_FILE="$1"    # Nombre del archivo .desktop
  local FOLDER="$2"          # Nombre de la carpeta
  
  # Construir el schema de gsettings para esta carpeta
  local SCHEMA="org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/$FOLDER/"
  
  # Obtener lista actual de aplicaciones en la carpeta
  local CURRENT_APPS=$(gsettings get "$SCHEMA" apps 2>/dev/null)
  
  # Si la carpeta no existe, crearla primero
  if [ -z "$CURRENT_APPS" ]; then
    echo "📁 Creando carpeta '$FOLDER'..."
    
    # Obtener lista de carpetas existentes
    local EXISTING_FOLDERS=$(gsettings get org.gnome.desktop.app-folders folder-children)
    
    # Añadir nueva carpeta a la lista
    local TRIMMED=$(echo "$EXISTING_FOLDERS" | sed "s/^\[//;s/\]$//")
    if [ -z "$TRIMMED" ] || [ "$TRIMMED" = "@as []" ]; then
      gsettings set org.gnome.desktop.app-folders folder-children "['$FOLDER']"
    else
      gsettings set org.gnome.desktop.app-folders folder-children "[$TRIMMED, '$FOLDER']"
    fi
    
    # Establecer nombre de la carpeta
    gsettings set "$SCHEMA" name "$FOLDER"
    
    # Inicializar lista de apps vacía
    CURRENT_APPS="[]"
  fi

  # Verificar si la app ya está en la carpeta
  if [[ "$CURRENT_APPS" == *"$DESKTOP_FILE"* ]]; then
    echo "ℹ️  La aplicación '$DESKTOP_FILE' ya está en la carpeta '$FOLDER'"
    return 0
  fi

  # Añadir la aplicación a la carpeta
  echo "📂 Añadiendo '$DESKTOP_FILE' a la carpeta '$FOLDER'..."
  local TRIMMED=$(echo "$CURRENT_APPS" | sed "s/^\[//;s/\]$//")
  
  # Si la lista está vacía, crear nueva lista
  if [ -z "$TRIMMED" ] || [ "$TRIMMED" = "@as " ]; then
    gsettings set "$SCHEMA" apps "['$DESKTOP_FILE']"
  else
    # Si la lista tiene elementos, añadir al final
    gsettings set "$SCHEMA" apps "[$TRIMMED, '$DESKTOP_FILE']"
  fi

  echo "✅ Aplicación añadida a la carpeta correctamente"
}

# Eliminar una aplicación de una carpeta en el grid de GNOME
#
# Uso: app2folder-remove archivo.desktop NombreCarpeta
#
# Ejemplo:
#   app2folder-remove 'Gmail.desktop' WebApps
app2folder-remove() {
  # Verificar que se pasaron exactamente 2 argumentos
  if [ "$#" -ne 2 ]; then
    local FOLDERS=$(gsettings get org.gnome.desktop.app-folders folder-children 2>/dev/null | tr -d "[],'")
    echo "Uso: app2folder-remove <archivo.desktop> <nombre_carpeta>"
    echo ""
    if [ -n "$FOLDERS" ]; then
      echo "Carpetas existentes: $FOLDERS"
    fi
    echo ""
    echo "Ejemplo:"
    echo "  app2folder-remove 'Gmail.desktop' WebApps"
    return 1
  fi

  # Verificar que estamos en GNOME
  if [ "$XDG_CURRENT_DESKTOP" != "GNOME" ]; then
    echo "⚠️  Advertencia: Esta función solo funciona en GNOME"
    return 1
  fi

  # Asignar parámetros a variables
  local DESKTOP_FILE="$1"
  local FOLDER="$2"
  
  # Construir schema de gsettings
  local SCHEMA="org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/$FOLDER/"
  
  # Obtener lista actual de aplicaciones
  local CURRENT_APPS=$(gsettings get "$SCHEMA" apps 2>/dev/null)

  # Verificar que la app está en la carpeta
  if [[ "$CURRENT_APPS" != *"$DESKTOP_FILE"* ]]; then
    echo "ℹ️  La aplicación '$DESKTOP_FILE' no está en la carpeta '$FOLDER'"
    return 0
  fi

  # Eliminar la aplicación de la lista
  echo "🗑️  Eliminando '$DESKTOP_FILE' de la carpeta '$FOLDER'..."
  
  # Convertir lista a array
  local RAW_LIST=$(echo "$CURRENT_APPS" | tr -d "[]'")
  IFS=',' read -ra APPS_ARRAY <<< "$RAW_LIST"

  # Filtrar la app a eliminar
  local NEW_APPS=()
  for app in "${APPS_ARRAY[@]}"; do
    app=$(echo "$app" | xargs)  # Eliminar espacios
    if [[ "$app" != "$DESKTOP_FILE" && -n "$app" ]]; then
      NEW_APPS+=("'$app'")
    fi
  done

  # Unir lista de nuevo
  local NEW_LIST=$(IFS=, ; echo "${NEW_APPS[*]}")

  # Actualizar gsettings
  gsettings set "$SCHEMA" apps "[$NEW_LIST]"

  echo "✅ Aplicación eliminada de la carpeta correctamente"
}

################################################################################
# FUNCIONES DE FORMATEO DE DISCOS
################################################################################

# Formatear un disco completo con exFAT (compatible con Windows/Mac/Linux)
# ADVERTENCIA: Esto borrará TODOS los datos del disco
# Uso: format-drive /dev/sdX 'Nombre del Disco'
format-drive() {
  if [ $# -ne 2 ]; then
    echo "Uso: format-drive <dispositivo> <nombre>"
    echo "Ejemplo: format-drive /dev/sda 'Mi USB'"
    echo -e "\nDiscos disponibles:"
    lsblk -d -o NAME -n | awk '{print "/dev/"$1}'
    return 1
  fi

  echo "⚠️  ADVERTENCIA: Esto borrará COMPLETAMENTE todos los datos en $1"
  echo "   y lo formateará como exFAT con el nombre '$2'"
  read -rp "¿Estás seguro de continuar? (s/N): " confirm

  if [[ "$confirm" =~ ^[Ss]$ ]]; then
    echo "🗑️  Limpiando disco..."
    sudo wipefs -a "$1"
    sudo dd if=/dev/zero of="$1" bs=1M count=100 status=progress
    
    echo "📝 Creando tabla de particiones..."
    sudo parted -s "$1" mklabel gpt
    sudo parted -s "$1" mkpart primary 1MiB 100%

    # Detectar nombre de partición (nvme usa p1, otros usan 1)
    partition="$([[ $1 == *"nvme"* ]] && echo "${1}p1" || echo "${1}1")"
    sudo partprobe "$1" || true
    sudo udevadm settle || true

    echo "💾 Formateando como exFAT..."
    sudo mkfs.exfat -n "$2" "$partition"

    echo "✅ Disco $1 formateado como exFAT y etiquetado '$2'"
  else
    echo "❌ Operación cancelada"
  fi
}

################################################################################
# FUNCIONES DE TRANSCODIFICACIÓN DE VIDEO
################################################################################

# Transcodificar video a 1080p optimizado para compartir online
# Usa H.264 con buen balance calidad/tamaño
# Uso: transcode-video-1080p video.mp4
# Resultado: video-1080p.mp4
transcode-video-1080p() {
  if [ $# -ne 1 ]; then
    echo "Uso: transcode-video-1080p <archivo_video>"
    echo "Resultado: archivo-1080p.mp4"
    return 1
  fi

  if ! command -v ffmpeg &> /dev/null; then
    echo "❌ Error: ffmpeg no está instalado"
    echo "Instalar con: sudo apt install ffmpeg"
    return 1
  fi

  echo "🎬 Transcodificando a 1080p..."
  ffmpeg -i "$1" -vf scale=1920:1080 -c:v libx264 -preset fast -crf 23 -c:a copy "${1%.*}-1080p.mp4"
  echo "✅ Video transcodificado: ${1%.*}-1080p.mp4"
}

# Transcodificar video a 4K optimizado con H.265
# Mejor compresión que H.264, ideal para archivos grandes
# Uso: transcode-video-4K video.mp4
# Resultado: video-optimized.mp4
transcode-video-4K() {
  if [ $# -ne 1 ]; then
    echo "Uso: transcode-video-4K <archivo_video>"
    echo "Resultado: archivo-optimized.mp4"
    return 1
  fi

  if ! command -v ffmpeg &> /dev/null; then
    echo "❌ Error: ffmpeg no está instalado"
    echo "Instalar con: sudo apt install ffmpeg"
    return 1
  fi

  echo "🎬 Transcodificando a 4K (H.265)..."
  ffmpeg -i "$1" -c:v libx265 -preset slow -crf 24 -c:a aac -b:a 192k "${1%.*}-optimized.mp4"
  echo "✅ Video transcodificado: ${1%.*}-optimized.mp4"
}

################################################################################
# FUNCIONES DE OPTIMIZACIÓN DE IMÁGENES
################################################################################

# Convertir imagen a JPG optimizado (calidad alta)
# Útil para reducir tamaño de wallpapers manteniendo calidad
# Uso: img2jpg imagen.png
# Resultado: imagen-optimized.jpg
img2jpg() {
  if [ $# -lt 1 ]; then
    echo "Uso: img2jpg <imagen> [opciones_imagemagick]"
    echo "Resultado: imagen-optimized.jpg"
    return 1
  fi

  if ! command -v magick &> /dev/null; then
    echo "❌ Error: ImageMagick no está instalado"
    echo "Instalar con: sudo apt install imagemagick"
    return 1
  fi

  img="$1"
  shift

  echo "🖼️  Optimizando imagen a JPG..."
  magick "$img" "$@" -quality 95 -strip "${img%.*}-optimized.jpg"
  echo "✅ Imagen optimizada: ${img%.*}-optimized.jpg"
}

# Convertir imagen a JPG pequeño para compartir online
# Redimensiona a máximo 1080px de ancho
# Uso: img2jpg-small imagen.png
# Resultado: imagen-optimized.jpg
img2jpg-small() {
  if [ $# -lt 1 ]; then
    echo "Uso: img2jpg-small <imagen> [opciones_imagemagick]"
    echo "Resultado: imagen-optimized.jpg (max 1080px ancho)"
    return 1
  fi

  if ! command -v magick &> /dev/null; then
    echo "❌ Error: ImageMagick no está instalado"
    echo "Instalar con: sudo apt install imagemagick"
    return 1
  fi

  img="$1"
  shift

  echo "🖼️  Optimizando imagen a JPG pequeño..."
  magick "$img" "$@" -resize 1080x\> -quality 95 -strip "${img%.*}-optimized.jpg"
  echo "✅ Imagen optimizada: ${img%.*}-optimized.jpg"
}

# Convertir imagen a PNG comprimido sin pérdida
# Máxima compresión manteniendo calidad perfecta
# Uso: img2png imagen.jpg
# Resultado: imagen-optimized.png
img2png() {
  if [ $# -lt 1 ]; then
    echo "Uso: img2png <imagen> [opciones_imagemagick]"
    echo "Resultado: imagen-optimized.png (comprimido sin pérdida)"
    return 1
  fi

  if ! command -v magick &> /dev/null; then
    echo "❌ Error: ImageMagick no está instalado"
    echo "Instalar con: sudo apt install imagemagick"
    return 1
  fi

  img="$1"
  shift

  echo "🖼️  Optimizando imagen a PNG..."
  magick "$img" "$@" -strip -define png:compression-filter=5 \
    -define png:compression-level=9 \
    -define png:compression-strategy=1 \
    -define png:exclude-chunk=all \
    "${img%.*}-optimized.png"
  echo "✅ Imagen optimizada: ${img%.*}-optimized.png"
}

################################################################################
# ALIASES ÚTILES
################################################################################

# Asegurar que teclados externos con tecla fn usen las teclas F por defecto
# Útil para teclados Apple y algunos teclados mecánicos
alias fix_fkeys='echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode'

# Arreglar el tamaño de ventana de Spotify (demasiado grande en algunas pantallas)
# Reduce el zoom a 1.5x
alias fix_spotify_window_size="sudo sed -i 's|^Exec=.*|Exec=spotify --force-device-scale-factor=1.5 %U|' /usr/local/share/applications/spotify.desktop"

################################################################################
# MENSAJE DE CARGA
################################################################################

# Mostrar mensaje cuando se carguen las funciones
echo "✅ Funciones de DevDeb cargadas correctamente"
echo "   📦 Compresión: compress, decompress"
echo "   🌐 WebApps: web2app, web2app-remove, app2folder, app2folder-remove"
echo "   🎬 Video: webm2mp4, transcode-video-1080p, transcode-video-4K"
echo "   🖼️  Imágenes: img2jpg, img2jpg-small, img2png"
echo "   💾 Utilidades: iso2sd, format-drive"
echo ""
echo "   💡 Usa 'web2app' para crear webapps desde sitios web"

