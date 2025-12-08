#!/bin/bash

################################################################################
# INSTALL-WEBAPPS.SH - Script para Instalar WebApps Populares
################################################################################
# Descripción:
#   Este script instala un conjunto de webapps populares usando la función
#   web2app de DevDeb. Puedes personalizar qué apps instalar comentando
#   o descomentando las líneas correspondientes.
#
# Uso:
#   ./install-webapps.sh
#
# Requisitos:
#   - Google Chrome instalado
#   - Funciones de DevDeb disponibles (functions.sh)
#
# Personalización:
#   - Comenta (añade #) las apps que NO quieras instalar
#   - Descomenta (quita #) las apps que SÍ quieras instalar
#   - Añade nuevas apps siguiendo el mismo formato
################################################################################

# Obtener el directorio donde está este script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Cargar funciones de DevDeb desde el mismo directorio
source "$SCRIPT_DIR/functions.sh"

echo "🚀 Instalando WebApps..."
echo ""

################################################################################
# GOOGLE WORKSPACE
################################################################################

echo "📧 Instalando Google Workspace..."

# Gmail
web2app 'Gmail' https://mail.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/gmail.png
app2folder 'Gmail.desktop' WebApps

# Google Calendar
web2app 'Google Calendar' https://calendar.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-calendar.png
app2folder 'Google Calendar.desktop' WebApps

# Google Drive
# web2app 'Google Drive' https://drive.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-drive.png
# app2folder 'Google Drive.desktop' WebApps

# Google Docs
# web2app 'Google Docs' https://docs.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-docs.png
# app2folder 'Google Docs.desktop' WebApps

# Google Sheets
# web2app 'Google Sheets' https://sheets.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-sheets.png
# app2folder 'Google Sheets.desktop' WebApps

# Google Meet
# web2app 'Google Meet' https://meet.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-meet.png
# app2folder 'Google Meet.desktop' WebApps

# Google Photos
web2app 'Google Photos' https://photos.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-photos.png
app2folder 'Google Photos.desktop' WebApps

# Google Contacts
web2app 'Google Contacts' https://contacts.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-contacts.png
app2folder 'Google Contacts.desktop' WebApps

# Google Keep
web2app 'Google Keep' https://keep.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-keep.png
app2folder 'Google Keep.desktop' WebApps

################################################################################
# PRODUCTIVIDAD
################################################################################

echo "📝 Instalando Apps de Productividad..."

# Notion
# web2app 'Notion' https://notion.so/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/notion.png
# app2folder 'Notion.desktop' WebApps

# Todoist
# web2app 'Todoist' https://todoist.com/app https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/todoist.png
# app2folder 'Todoist.desktop' WebApps

# Trello
# web2app 'Trello' https://trello.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/trello.png
# app2folder 'Trello.desktop' WebApps

# Asana
# web2app 'Asana' https://app.asana.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/asana.png
# app2folder 'Asana.desktop' WebApps

################################################################################
# COMUNICACIÓN
################################################################################

echo "💬 Instalando Apps de Comunicación..."

# WhatsApp Web
web2app 'WhatsApp' https://web.whatsapp.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/whatsapp.png
app2folder 'WhatsApp.desktop' WebApps

# Telegram Web
# web2app 'Telegram' https://web.telegram.org/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/telegram.png
# app2folder 'Telegram.desktop' WebApps

# Slack
# web2app 'Slack' https://slack.com/signin https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/slack.png
# app2folder 'Slack.desktop' WebApps

# Discord Web
web2app 'Discord' https://discord.com/app https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/discord.png
app2folder 'Discord.desktop' WebApps

################################################################################
# IA Y CHATBOTS
################################################################################

echo "🤖 Instalando Apps de IA..."

# ChatGPT
# web2app 'Chat GPT' https://chatgpt.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/chatgpt.png
# app2folder 'Chat GPT.desktop' WebApps

# Claude
# web2app 'Claude' https://claude.ai/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/anthropic.png
# app2folder 'Claude.desktop' WebApps

# Gemini
web2app 'Gemini' https://gemini.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-gemini.png
app2folder 'Gemini.desktop' WebApps

################################################################################
# DESARROLLO
################################################################################

echo "💻 Instalando Apps de Desarrollo..."

# GitHub
web2app 'GitHub' https://github.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/github.png
app2folder 'GitHub.desktop' WebApps

# GitLab
# web2app 'GitLab' https://gitlab.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/gitlab.png
# app2folder 'GitLab.desktop' WebApps

# Vercel
# web2app 'Vercel' https://vercel.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/vercel.png
# app2folder 'Vercel.desktop' WebApps

# Railway
# web2app 'Railway' https://railway.app/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/railway.png
# app2folder 'Railway.desktop' WebApps

# Figma
web2app 'Figma' https://figma.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/figma.png
app2folder 'Figma.desktop' WebApps

################################################################################
# REDES SOCIALES
################################################################################

echo "📱 Instalando Redes Sociales..."

# Twitter/X
# web2app 'Twitter' https://twitter.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/twitter.png
# app2folder 'Twitter.desktop' WebApps

# LinkedIn
web2app 'LinkedIn' https://linkedin.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/linkedin.png
app2folder 'LinkedIn.desktop' WebApps

# Reddit
# web2app 'Reddit' https://reddit.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/reddit.png
# app2folder 'Reddit.desktop' WebApps

################################################################################
# MULTIMEDIA
################################################################################

echo "🎵 Instalando Apps Multimedia..."

# YouTube
web2app 'YouTube' https://youtube.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/youtube.png
app2folder 'YouTube.desktop' WebApps

# Spotify Web
web2app 'Spotify Web' https://open.spotify.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/spotify.png
app2folder 'Spotify Web.desktop' WebApps

# YouTube Music
# web2app 'YouTube Music' https://music.youtube.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/youtube-music.png
# app2folder 'YouTube Music.desktop' WebApps

################################################################################
# OTRAS APPS ÚTILES
################################################################################

echo "🔧 Instalando Otras Apps..."

# Tailscale (VPN)
# web2app 'Tailscale' https://login.tailscale.com/admin/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/tailscale-light.png
# app2folder 'Tailscale.desktop' WebApps

# Excalidraw (Dibujo)
# web2app 'Excalidraw' https://excalidraw.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/excalidraw.png
# app2folder 'Excalidraw.desktop' WebApps

# Canva
# web2app 'Canva' https://canva.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/canva.png
# app2folder 'Canva.desktop' WebApps

################################################################################
# FINALIZACIÓN
################################################################################

echo ""
echo "✅ ¡WebApps instaladas correctamente!"
echo ""
echo "📂 Puedes encontrarlas en:"
echo "   - Menú de aplicaciones de GNOME"
echo "   - Carpeta 'WebApps' en el grid de aplicaciones"
echo ""
echo "💡 Consejos:"
echo "   - Para eliminar una webapp: web2app-remove 'NombreApp'"
echo "   - Para ver todas las webapps: ls ~/.local/share/applications/*.desktop"
echo "   - Para personalizar este script: nano $0"
echo ""
