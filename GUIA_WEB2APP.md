# Guía Completa: Crear WebApps con web2app

## 📱 ¿Qué es web2app?

`web2app` es una función de Bash incluida en Omakub que convierte cualquier sitio web en una aplicación de escritorio independiente. La webapp se abre en una ventana de Chrome dedicada, sin barras de navegación, como si fuera una aplicación nativa.

---

## 🎯 Características

- ✅ Crea lanzadores de escritorio (.desktop)
- ✅ Abre sitios web en ventanas dedicadas de Chrome
- ✅ Usa iconos personalizados
- ✅ Aparece en el menú de aplicaciones de GNOME
- ✅ Se puede organizar en carpetas
- ✅ Funciona como aplicación independiente

---

## 📋 Requisitos Previos

### 1. Google Chrome Instalado

```bash
# Verificar si Chrome está instalado
which google-chrome

# Si no está instalado, instalarlo
source ~/.local/share/omakub/install/desktop/app-chrome.sh
```

### 2. Función web2app Disponible

La función debe estar cargada en tu shell. Esto se hace automáticamente si has instalado Omakub, pero puedes verificarlo:

```bash
# Verificar que la función existe
type web2app

# Si no existe, cargarla manualmente
source ~/.local/share/omakub/defaults/bash/functions
```

---

## 🚀 Uso Básico

### Sintaxis

```bash
web2app '<NombreApp>' <URL> <URLIcono>
```

### Parámetros

1. **NombreApp**: Nombre de la aplicación (entre comillas si tiene espacios)
2. **URL**: URL completa del sitio web
3. **URLIcono**: URL del icono en formato PNG

### Ejemplo Simple

```bash
web2app 'YouTube' https://youtube.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/youtube.png
```

---

## 📝 Ejemplos Prácticos

### Aplicaciones Populares

#### Chat GPT
```bash
web2app 'Chat GPT' https://chatgpt.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/chatgpt.png
```

#### Gmail
```bash
web2app 'Gmail' https://mail.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/gmail.png
```

#### Google Calendar
```bash
web2app 'Google Calendar' https://calendar.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-calendar.png
```

#### Google Drive
```bash
web2app 'Google Drive' https://drive.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-drive.png
```

#### WhatsApp Web
```bash
web2app 'WhatsApp' https://web.whatsapp.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/whatsapp.png
```

#### Notion
```bash
web2app 'Notion' https://notion.so/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/notion.png
```

#### Figma
```bash
web2app 'Figma' https://figma.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/figma.png
```

#### Spotify Web
```bash
web2app 'Spotify Web' https://open.spotify.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/spotify.png
```

#### GitHub
```bash
web2app 'GitHub' https://github.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/github.png
```

#### Twitter/X
```bash
web2app 'Twitter' https://twitter.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/twitter.png
```

---

## 🎨 Encontrar Iconos

### Opción 1: Dashboard Icons (Recomendado)

**URL**: https://dashboardicons.com

Busca el icono que necesitas y copia la URL PNG:

```
https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/NOMBRE.png
```

**Ejemplos de nombres**:
- `chatgpt.png`
- `gmail.png`
- `youtube.png`
- `spotify.png`
- `github.png`

### Opción 2: Iconos Personalizados

Puedes usar cualquier imagen PNG de internet:

```bash
web2app 'Mi App' https://miapp.com/ https://ejemplo.com/icono.png
```

### Opción 3: Icono Local

Si tienes un icono local, primero súbelo a un servicio como:
- GitHub (en un repo público)
- Imgur
- Cualquier hosting de imágenes

---

## 📂 Organizar WebApps en Carpetas

### Crear Carpeta de WebApps

Primero, asegúrate de que existe una carpeta "WebApps" en GNOME:

```bash
# Ver carpetas existentes
gsettings get org.gnome.desktop.app-folders folder-children

# Si no existe "WebApps", puedes crearla manualmente en GNOME
# o usar el script de Omakub que la crea automáticamente
```

### Añadir WebApp a Carpeta

Después de crear la webapp, añádela a una carpeta:

```bash
# Crear webapp
web2app 'Gmail' https://mail.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/gmail.png

# Añadir a carpeta WebApps
app2folder 'Gmail.desktop' WebApps
```

### Ejemplo Completo

```bash
# Crear varias webapps y organizarlas
web2app 'Gmail' https://mail.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/gmail.png
app2folder 'Gmail.desktop' WebApps

web2app 'Google Calendar' https://calendar.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-calendar.png
app2folder 'Google Calendar.desktop' WebApps

web2app 'Google Drive' https://drive.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-drive.png
app2folder 'Google Drive.desktop' WebApps
```

---

## 🗑️ Eliminar WebApps

### Eliminar una WebApp

```bash
web2app-remove 'NombreApp'
```

### Ejemplos

```bash
# Eliminar Gmail
web2app-remove 'Gmail'

# Eliminar Chat GPT
web2app-remove 'Chat GPT'
```

### Eliminar de Carpeta

Si la webapp está en una carpeta, primero elimínala de la carpeta:

```bash
# Eliminar de carpeta
app2folder-remove 'Gmail.desktop' WebApps

# Luego eliminar la webapp
web2app-remove 'Gmail'
```

---

## 🔧 Cómo Funciona (Detalles Técnicos)

### Archivos Creados

Cuando ejecutas `web2app`, se crean dos archivos:

1. **Archivo .desktop**: `~/.local/share/applications/NombreApp.desktop`
2. **Icono PNG**: `~/.local/share/applications/icons/NombreApp.png`

### Contenido del Archivo .desktop

```ini
[Desktop Entry]
Version=1.0
Name=NombreApp
Comment=NombreApp
Exec=google-chrome --app="URL" --name="NombreApp" --class="NombreApp" --window-size=800,600
Terminal=false
Type=Application
Icon=/home/usuario/.local/share/applications/icons/NombreApp.png
Categories=GTK;
MimeType=text/html;text/xml;application/xhtml_xml;
StartupNotify=true
```

### Parámetros de Chrome

- `--app="URL"`: Abre la URL en modo aplicación (sin barras)
- `--name="NombreApp"`: Nombre de la ventana
- `--class="NombreApp"`: Clase de la ventana (para agrupación)
- `--window-size=800,600`: Tamaño inicial de la ventana

---

## 📜 Script de Instalación Masiva

### Crear Múltiples WebApps de una Vez

Crea un script para instalar todas tus webapps favoritas:

```bash
#!/bin/bash
# install-my-webapps.sh

# Cargar funciones de Omakub
source ~/.local/share/omakub/defaults/bash/functions

# Google Apps
web2app 'Gmail' https://mail.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/gmail.png
app2folder 'Gmail.desktop' WebApps

web2app 'Google Calendar' https://calendar.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-calendar.png
app2folder 'Google Calendar.desktop' WebApps

web2app 'Google Drive' https://drive.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-drive.png
app2folder 'Google Drive.desktop' WebApps

# Productividad
web2app 'Notion' https://notion.so/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/notion.png
app2folder 'Notion.desktop' WebApps

web2app 'Figma' https://figma.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/figma.png
app2folder 'Figma.desktop' WebApps

# Comunicación
web2app 'WhatsApp' https://web.whatsapp.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/whatsapp.png
app2folder 'WhatsApp.desktop' WebApps

web2app 'Chat GPT' https://chatgpt.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/chatgpt.png
app2folder 'Chat GPT.desktop' WebApps

echo "✅ WebApps instaladas correctamente!"
```

### Ejecutar el Script

```bash
# Hacer ejecutable
chmod +x install-my-webapps.sh

# Ejecutar
./install-my-webapps.sh
```

---

## 🎯 Casos de Uso Comunes

### Suite de Google Workspace

```bash
web2app 'Gmail' https://mail.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/gmail.png
web2app 'Google Calendar' https://calendar.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-calendar.png
web2app 'Google Drive' https://drive.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-drive.png
web2app 'Google Docs' https://docs.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-docs.png
web2app 'Google Sheets' https://sheets.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-sheets.png
web2app 'Google Meet' https://meet.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-meet.png
```

### Herramientas de Desarrollo

```bash
web2app 'GitHub' https://github.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/github.png
web2app 'GitLab' https://gitlab.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/gitlab.png
web2app 'Vercel' https://vercel.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/vercel.png
web2app 'Railway' https://railway.app/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/railway.png
```

### Redes Sociales

```bash
web2app 'Twitter' https://twitter.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/twitter.png
web2app 'LinkedIn' https://linkedin.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/linkedin.png
web2app 'Reddit' https://reddit.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/reddit.png
```

---

## 🐛 Solución de Problemas

### Problema: "Command not found: web2app"

**Solución**: Cargar las funciones manualmente

```bash
source ~/.local/share/omakub/defaults/bash/functions
```

O añadir a tu `~/.bashrc`:

```bash
echo 'source ~/.local/share/omakub/defaults/bash/functions' >> ~/.bashrc
source ~/.bashrc
```

### Problema: "Failed to download icon"

**Causas posibles**:
1. URL del icono incorrecta
2. Sin conexión a internet
3. Icono no existe

**Solución**: Verificar la URL del icono

```bash
# Probar descargar el icono manualmente
curl -I https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/gmail.png
```

### Problema: La webapp no aparece en el menú

**Solución**: Actualizar la caché de aplicaciones

```bash
# Actualizar base de datos de aplicaciones
update-desktop-database ~/.local/share/applications/
```

### Problema: Chrome no está instalado

**Solución**: Instalar Chrome

```bash
source ~/.local/share/omakub/install/desktop/app-chrome.sh
```

---

## 💡 Consejos y Trucos

### 1. Usar URLs Específicas

Puedes usar URLs específicas para abrir directamente en una sección:

```bash
# Gmail - Bandeja de entrada
web2app 'Gmail Inbox' https://mail.google.com/mail/u/0/#inbox https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/gmail.png

# YouTube - Suscripciones
web2app 'YouTube Subs' https://youtube.com/feed/subscriptions https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/youtube.png
```

### 2. Múltiples Cuentas

Puedes crear webapps para diferentes cuentas:

```bash
web2app 'Gmail Personal' https://mail.google.com/mail/u/0/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/gmail.png
web2app 'Gmail Trabajo' https://mail.google.com/mail/u/1/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/gmail.png
```

### 3. Listar WebApps Instaladas

```bash
# Ver todas las webapps
ls ~/.local/share/applications/*.desktop | grep -v "^/usr"

# Ver iconos
ls ~/.local/share/applications/icons/
```

### 4. Editar WebApp Existente

```bash
# Editar el archivo .desktop
nano ~/.local/share/applications/'Gmail.desktop'

# Cambiar tamaño de ventana, URL, etc.
```

---

## 📚 Recursos Adicionales

### Iconos
- **Dashboard Icons**: https://dashboardicons.com
- **Simple Icons**: https://simpleicons.org
- **Flaticon**: https://flaticon.com

### Documentación
- **Desktop Entry Spec**: https://specifications.freedesktop.org/desktop-entry-spec/latest/
- **Chrome App Mode**: https://developer.chrome.com/docs/apps/

---

## ✅ Checklist de Creación de WebApp

- [ ] Chrome instalado
- [ ] Función web2app cargada
- [ ] Nombre de la app decidido
- [ ] URL del sitio web
- [ ] URL del icono PNG encontrada
- [ ] Ejecutar comando web2app
- [ ] Verificar que aparece en el menú
- [ ] (Opcional) Añadir a carpeta WebApps
- [ ] Probar que funciona correctamente

---

## 🎉 Ejemplo Completo Paso a Paso

```bash
# 1. Asegurarse de que las funciones están cargadas
source ~/.local/share/omakub/defaults/bash/functions

# 2. Crear la webapp
web2app 'Notion' https://notion.so/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/notion.png

# 3. Añadir a carpeta (opcional)
app2folder 'Notion.desktop' WebApps

# 4. Verificar que se creó
ls ~/.local/share/applications/Notion.desktop

# 5. Abrir desde el menú de aplicaciones
# Busca "Notion" en el menú de GNOME

# 6. Si quieres eliminarla más tarde
# web2app-remove 'Notion'
```

---

¡Ahora puedes convertir cualquier sitio web en una aplicación de escritorio! 🚀
