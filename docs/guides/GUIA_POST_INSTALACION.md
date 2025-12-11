# Guía del Script de Post-Instalación para Debian 13 GNOME

## 📋 Descripción General

El script `post-install-gnome.sh` automatiza la configuración inicial de un sistema Debian 13 Trixie con GNOME recién instalado. Instala software esencial, configura tiendas de aplicaciones, añade codecs multimedia y personaliza el aspecto del sistema.

---

## 🚀 Uso del Script

### Ejecución

```bash
# Desde el directorio de DevDeb
cd ~/Workspace/Repositorios/Instalación/devdeb

# Ejecutar con sudo
sudo ./scripts/setup/post-install-gnome.sh
```

### Requisitos Previos

- ✅ Debian 13 Trixie instalado
- ✅ Entorno de escritorio GNOME
- ✅ Conexión a internet activa
- ✅ Privilegios sudo

---

## 📦 Secciones del Script

### 1. Software Esencial

#### Herramientas de Desarrollo

**¿Qué se instala?**

| Paquete | Descripción | Para qué sirve |
|---------|-------------|----------------|
| `linux-headers-$(uname -r)` | Cabeceras del kernel | Compilar módulos del kernel y drivers |
| `build-essential` | Herramientas de compilación | Incluye gcc, g++, make - esencial para compilar software |
| `checkinstall` | Creador de paquetes | Convertir código fuente en paquetes .deb |
| `make` | Herramienta de construcción | Automatizar compilación de proyectos |
| `automake` | Generador de Makefiles | Crear Makefiles portables |
| `cmake` | Sistema de construcción | Gestionar compilación de proyectos complejos |
| `autoconf` | Generador de scripts | Crear scripts de configuración |
| `gcc` | Compilador de C | Compilar programas en C |

**Ejemplo de uso:**
```bash
# Compilar un programa desde código fuente
./configure
make
sudo checkinstall  # Crea un .deb en lugar de make install
```

#### Herramientas de Monitoreo

| Paquete | Descripción | Para qué sirve |
|---------|-------------|----------------|
| `btop` | Monitor de sistema moderno | Ver CPU, RAM, disco, red con interfaz hermosa |
| `htop` | Monitor de sistema interactivo | Alternativa a top, más fácil de usar |
| `inxi` | Información del sistema | Mostrar hardware y configuración detallada |

**Ejemplo de uso:**
```bash
# Ver uso de recursos en tiempo real
btop

# Ver información del sistema
inxi -Fxz
```

#### Herramientas de Red y Desarrollo

| Paquete | Descripción | Para qué sirve |
|---------|-------------|----------------|
| `curl` | Cliente HTTP | Descargar archivos, hacer peticiones HTTP |
| `git` | Control de versiones | Gestionar código fuente, clonar repositorios |
| `libfuse2` | Biblioteca FUSE | Montar sistemas de archivos en espacio de usuario |

**Ejemplo de uso:**
```bash
# Descargar archivo
curl -O https://ejemplo.com/archivo.zip

# Clonar repositorio
git clone https://github.com/usuario/repo.git
```

#### Soporte de Sistemas de Archivos

| Paquete | Descripción | Para qué sirve |
|---------|-------------|----------------|
| `exfat-fuse` | Soporte exFAT | Leer/escribir USBs y tarjetas SD formateadas en exFAT |
| `hfsplus` | Soporte HFS+ | Leer/escribir discos de macOS |

**Ejemplo de uso:**
```bash
# Montar USB exFAT
sudo mount -t exfat /dev/sdb1 /mnt/usb

# Montar disco de macOS
sudo mount -t hfsplus /dev/sdc2 /mnt/mac
```

#### Aplicaciones Multimedia

| Paquete | Descripción | Para qué sirve |
|---------|-------------|----------------|
| `vlc` | Reproductor multimedia | Reproducir videos, música, DVDs - soporta casi todos los formatos |
| `gimp` | Editor de imágenes | Editar fotos, crear gráficos (alternativa a Photoshop) |
| `gparted` | Editor de particiones | Redimensionar, crear, eliminar particiones de disco |

**Ejemplo de uso:**
```bash
# Abrir VLC
vlc video.mp4

# Editar imagen con GIMP
gimp foto.jpg

# Gestionar particiones (requiere sudo)
sudo gparted
```

#### Herramientas de Compresión

| Paquete | Descripción | Para qué sirve |
|---------|-------------|----------------|
| `p7zip-full` | Compresor 7-Zip | Crear/extraer archivos .7z (mejor compresión) |
| `p7zip-rar` | Soporte RAR en 7zip | Extraer archivos .rar con 7zip |
| `unrar` | Descompresor RAR | Extraer archivos .rar |
| `zip/unzip` | Compresor ZIP | Crear/extraer archivos .zip |
| `bzip2` | Compresor bzip2 | Comprimir con algoritmo bzip2 |
| `lzma` | Compresor LZMA | Comprimir con algoritmo LZMA |

**Ejemplo de uso:**
```bash
# Crear archivo 7z
7z a archivo.7z carpeta/

# Extraer RAR
unrar x archivo.rar

# Crear ZIP
zip -r archivo.zip carpeta/

# Extraer ZIP
unzip archivo.zip
```

---

### 2. Tiendas de Software

#### Synaptic

**¿Qué es?**
Gestor de paquetes gráfico avanzado para APT.

**Para qué sirve:**
- Buscar paquetes con filtros avanzados
- Ver dependencias de paquetes
- Instalar/desinstalar software
- Gestionar repositorios

**Ejemplo de uso:**
```bash
# Abrir Synaptic
sudo synaptic
```

#### Flatpak

**¿Qué es?**
Sistema de paquetes universal para aplicaciones de escritorio.

**Para qué sirve:**
- Instalar aplicaciones que no están en repositorios de Debian
- Tener versiones más recientes de aplicaciones
- Aplicaciones aisladas (sandboxed) para mayor seguridad

**Ejemplo de uso:**
```bash
# Buscar aplicación
flatpak search spotify

# Instalar aplicación
flatpak install flathub com.spotify.Client

# Ejecutar aplicación
flatpak run com.spotify.Client

# Listar instaladas
flatpak list

# Actualizar todas
flatpak update
```

#### Flathub

**¿Qué es?**
Repositorio principal de aplicaciones Flatpak.

**Para qué sirve:**
- Acceder a miles de aplicaciones
- Instalar software popular (Spotify, Discord, Steam, etc.)

---

### 3. Codecs Multimedia

#### GStreamer Plugins

| Paquete | Descripción | Para qué sirve |
|---------|-------------|----------------|
| `gstreamer1.0-pulseaudio` | Plugin PulseAudio | Reproducir audio a través de PulseAudio |
| `gstreamer1.0-plugins-bad` | Plugins de calidad variable | Formatos menos comunes (WebM, etc.) |
| `gstreamer1.0-plugins-ugly` | Plugins con problemas de licencia | MP3, DVD, etc. |
| `gstreamer1.0-libav` | Wrapper de FFmpeg | Usar codecs de FFmpeg en GStreamer |

**Para qué sirve:**
Permite reproducir videos y audio en navegadores web, reproductores multimedia y aplicaciones GNOME.

#### Codecs Adicionales

| Paquete | Descripción | Para qué sirve |
|---------|-------------|----------------|
| `libavcodec-extra` | Codecs adicionales | Soporte para más formatos de video/audio |
| `vorbis-tools` | Herramientas Ogg Vorbis | Reproducir/convertir archivos .ogg |
| `ffmpeg` | Suite de conversión multimedia | Convertir, grabar, transmitir audio/video |
| `ffmpeg-doc` | Documentación de FFmpeg | Aprender a usar FFmpeg |

**Ejemplo de uso:**
```bash
# Convertir video a MP4
ffmpeg -i video.avi video.mp4

# Extraer audio de video
ffmpeg -i video.mp4 -vn audio.mp3

# Redimensionar video
ffmpeg -i input.mp4 -vf scale=1280:720 output.mp4
```

---

### 4. Aspecto del Sistema

#### Papirus Icon Theme

**¿Qué es?**
Conjunto de iconos moderno, colorido y consistente.

**Para qué sirve:**
- Mejorar el aspecto visual de GNOME
- Iconos más modernos y atractivos
- Mejor visibilidad y reconocimiento

**Cómo se aplica:**
El script automáticamente configura Papirus como tema de iconos predeterminado usando `gsettings`.

**Cambiar manualmente:**
```bash
# Ver temas disponibles
ls /usr/share/icons/

# Cambiar tema de iconos
gsettings set org.gnome.desktop.interface icon-theme 'Papirus'

# O usar GNOME Tweaks
gnome-tweaks
```

---

### 5. Verificación del Sistema

#### Información de Audio (PipeWire)

**Comando:** `inxi -Aa`

**Para qué sirve:**
- Verificar que el sistema de audio funciona
- Ver dispositivos de audio detectados
- Comprobar drivers de audio

**Salida típica:**
```
Audio:
  Device-1: Intel Sunrise Point-LP HD Audio
  Sound Server: PipeWire v: 0.3.65
```

#### Aceleración Gráfica (Mesa)

**Comando:** `glxinfo | grep "OpenGL version"`

**Para qué sirve:**
- Verificar que la aceleración por hardware funciona
- Ver versión de OpenGL soportada
- Comprobar drivers gráficos

**Salida típica:**
```
OpenGL version string: 4.6 Mesa 23.2.1
```

**¿Qué significa?**
- Si muestra "Mesa" → Drivers open-source funcionando
- Si muestra "NVIDIA" → Drivers propietarios de NVIDIA
- Si muestra "llvmpipe" → ⚠️ Sin aceleración (software rendering)

---

### 6. Limpieza y Optimización

#### Comandos de Limpieza

| Comando | Para qué sirve |
|---------|----------------|
| `apt autoremove -y` | Eliminar paquetes que ya no se necesitan |
| `apt autoclean` | Limpiar caché de paquetes descargados |

**Ejemplo manual:**
```bash
# Ver espacio usado por caché
du -sh /var/cache/apt/archives/

# Limpiar caché
sudo apt clean

# Eliminar paquetes huérfanos
sudo apt autoremove
```

---

## 🎯 Resumen de lo que se Instala

### Categorías

1. **Desarrollo** (12 paquetes)
   - Compiladores, herramientas de construcción, git

2. **Monitoreo** (3 paquetes)
   - btop, htop, inxi

3. **Multimedia** (3 paquetes)
   - VLC, GIMP, codecs

4. **Utilidades** (10 paquetes)
   - Compresión, sistemas de archivos, gparted

5. **Gestores** (3 paquetes)
   - Synaptic, Flatpak, GNOME Software Plugin

6. **Temas** (1 paquete)
   - Papirus Icon Theme

**Total:** ~32 paquetes + dependencias

---

## 💡 Casos de Uso Prácticos

### Desarrollador de Software

```bash
# Después de ejecutar el script, puedes:

# Clonar proyecto
git clone https://github.com/usuario/proyecto.git
cd proyecto

# Compilar
./configure
make
sudo checkinstall

# Monitorear recursos mientras desarrollas
btop
```

### Usuario Multimedia

```bash
# Reproducir cualquier formato de video
vlc pelicula.mkv

# Editar fotos
gimp foto.jpg

# Convertir videos
ffmpeg -i video.mov video.mp4
```

### Administrador de Sistema

```bash
# Ver información del sistema
inxi -Fxz

# Gestionar particiones
sudo gparted

# Instalar software
sudo synaptic
# o
flatpak install flathub com.app.Name
```

---

## 🐛 Solución de Problemas

### Error: "E: Unable to locate package"

**Problema:** Algún paquete no se encuentra.

**Solución:**
```bash
# Actualizar repositorios
sudo apt update

# Verificar que el paquete existe
apt search nombre-paquete
```

### Error: "Permission denied"

**Problema:** No se ejecutó con sudo.

**Solución:**
```bash
# Ejecutar con sudo
sudo ./scripts/setup/post-install-gnome.sh
```

### Flatpak no funciona

**Problema:** Aplicaciones Flatpak no se ven en GNOME Software.

**Solución:**
```bash
# Reiniciar GNOME Software
killall gnome-software

# Verificar que Flathub está añadido
flatpak remotes

# Actualizar
flatpak update
```

### Codecs no funcionan

**Problema:** Algunos videos no se reproducen.

**Solución:**
```bash
# Instalar codecs adicionales
sudo apt install ubuntu-restricted-extras

# O usar VLC que tiene codecs integrados
vlc video.mp4
```

---

## 📚 Recursos Adicionales

### Documentación Oficial

- **Debian**: https://www.debian.org/doc/
- **GNOME**: https://help.gnome.org/
- **Flatpak**: https://docs.flatpak.org/
- **FFmpeg**: https://ffmpeg.org/documentation.html

### Herramientas Recomendadas

- **GNOME Tweaks**: Personalizar GNOME
  ```bash
  sudo apt install gnome-tweaks
  ```

- **GNOME Extensions**: Añadir funcionalidades
  ```bash
  # Instalar gestor de extensiones
  sudo apt install gnome-shell-extension-manager
  ```

---

## ✅ Checklist Post-Instalación

Después de ejecutar el script:

- [ ] Reiniciar el sistema
- [ ] Verificar que VLC reproduce videos
- [ ] Abrir GNOME Software y explorar Flatpak
- [ ] Ejecutar `btop` para ver el sistema
- [ ] Comprobar que el tema Papirus está aplicado
- [ ] Instalar aplicaciones adicionales según necesites
- [ ] Configurar tus preferencias en GNOME Configuración

---

**¡Tu sistema Debian 13 GNOME está listo para usar! 🚀**
