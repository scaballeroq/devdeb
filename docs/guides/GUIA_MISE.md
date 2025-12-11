# Guía de Mise - Gestor de Versiones para DevDeb

## 📋 ¿Qué es Mise?

**Mise** es un gestor moderno de versiones de herramientas de desarrollo que te permite instalar y cambiar entre múltiples versiones de lenguajes de programación y herramientas CLI.

### Características Principales

✅ **Rápido** - Escrito en Rust, mucho más rápido que asdf  
✅ **Compatible** - Funciona con archivos `.tool-versions` de asdf  
✅ **Múltiples lenguajes** - Ruby, Node, Python, Go, PHP, Elixir, Rust, Java y más  
✅ **Variables de entorno** - Gestión por proyecto  
✅ **Activación automática** - Al entrar en directorios  
✅ **Multiplataforma** - Linux, macOS, Windows

---

## 🚀 Instalación

### Instalación Automática con DevDeb

```bash
# Desde el directorio de DevDeb
cd ~/Workspace/Repositorios/Instalación/devdeb
./scripts/tools/mise.sh
```

### Instalación Manual

```bash
# Instalar dependencias
sudo apt update && sudo apt install -y gpg wget curl

# Añadir repositorio de Mise
sudo install -dm 755 /etc/apt/keyrings
wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg 1>/dev/null
echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=$(dpkg --print-architecture)] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list

# Instalar Mise
sudo apt update
sudo apt install -y mise
```

---

## ⚙️ Configuración

### Activar en Bash

```bash
# Añadir a ~/.bashrc
echo 'eval "$(mise activate bash)"' >> ~/.bashrc

# Recargar configuración
source ~/.bashrc
```

### Activar en Zsh

```bash
# Añadir a ~/.zshrc
echo 'eval "$(mise activate zsh)"' >> ~/.zshrc

# Recargar configuración
source ~/.zshrc
```

### Verificar Instalación

```bash
# Ver versión de Mise
mise --version

# Ver ayuda
mise help
```

---

## 📚 Uso Básico

### Instalar Lenguajes

#### Node.js

```bash
# Instalar última versión LTS globalmente
mise use --global node@lts

# Instalar versión específica
mise use --global node@20

# Instalar en proyecto actual (crea .tool-versions)
mise use node@18
```

#### Python

```bash
# Instalar última versión
mise use --global python@latest

# Instalar versión específica
mise use --global python@3.11
```

#### Ruby

```bash
# Instalar última versión
mise use --global ruby@latest

# Instalar versión específica
mise use --global ruby@3.2.0
```

#### Go

```bash
# Instalar última versión
mise use --global go@latest

# Instalar versión específica
mise use --global go@1.21
```

#### PHP

```bash
# Instalar última versión
mise use --global php@latest

# Instalar versión específica
mise use --global php@8.2
```

#### Rust

```bash
# Instalar última versión
mise use --global rust@latest
```

#### Java

```bash
# Instalar última versión
mise use --global java@latest

# Instalar versión específica (OpenJDK)
mise use --global java@17
```

---

## 🔍 Comandos de Gestión

### Ver Versiones

```bash
# Ver todas las versiones instaladas
mise list

# Ver versiones de un lenguaje específico
mise list node

# Ver versiones disponibles para instalar
mise ls-remote node

# Ver versiones disponibles con filtro
mise ls-remote node 20
```

### Gestionar Versiones

```bash
# Actualizar todas las herramientas
mise upgrade

# Actualizar una herramienta específica
mise upgrade node

# Desinstalar una versión
mise uninstall node@18

# Ver qué versión se está usando
mise current

# Ver qué versión se usará en un directorio
mise current node
```

### Información

```bash
# Ver configuración actual
mise config

# Ver dónde están instaladas las herramientas
mise where node

# Ver todas las herramientas disponibles
mise registry
```

---

## 📁 Uso por Proyecto

### Archivo `.tool-versions`

Mise usa archivos `.tool-versions` para especificar versiones por proyecto:

```bash
# Crear proyecto
mkdir mi-proyecto
cd mi-proyecto

# Especificar versiones para este proyecto
mise use node@20
mise use python@3.11
mise use ruby@3.2

# Esto crea un archivo .tool-versions
cat .tool-versions
```

**Contenido de `.tool-versions`:**
```
node 20
python 3.11
ruby 3.2
```

### Activación Automática

Cuando entras en un directorio con `.tool-versions`, Mise activa automáticamente las versiones especificadas:

```bash
cd mi-proyecto
# Mise activa automáticamente node@20, python@3.11, ruby@3.2

node --version  # v20.x.x
python --version  # Python 3.11.x
ruby --version  # ruby 3.2.x
```

---

## 🌍 Variables de Entorno

### Archivo `.mise.toml`

Puedes configurar variables de entorno por proyecto:

```bash
# Crear .mise.toml en tu proyecto
cat > .mise.toml << 'EOF'
[env]
DATABASE_URL = "postgresql://localhost/mydb"
API_KEY = "secret-key"
NODE_ENV = "development"
EOF
```

### Usar Variables

```bash
cd mi-proyecto
# Las variables se cargan automáticamente

echo $DATABASE_URL  # postgresql://localhost/mydb
echo $API_KEY       # secret-key
```

---

## 🔧 Configuración Avanzada

### Configuración Global

Archivo: `~/.config/mise/config.toml`

```toml
# Configuración global de Mise
[settings]
experimental = true
legacy_version_file = true

# Versiones globales por defecto
[tools]
node = "lts"
python = "3.11"
```

### Aliases

```bash
# Crear alias para versiones
mise alias set node lts 20
mise alias set python latest 3.11

# Usar alias
mise use --global node@lts
```

---

## 💡 Ejemplos Prácticos

### Proyecto Node.js

```bash
# Crear proyecto
mkdir my-app
cd my-app

# Configurar versiones
mise use node@20
mise use python@3.11  # Para scripts de build

# Instalar dependencias
npm init -y
npm install express

# Las versiones se mantienen en este proyecto
```

### Proyecto Ruby on Rails

```bash
# Crear proyecto
mkdir rails-app
cd rails-app

# Configurar Ruby
mise use ruby@3.2

# Instalar Rails
gem install rails

# Crear app
rails new .
```

### Proyecto Multi-lenguaje

```bash
# Backend en Go, Frontend en Node
mkdir fullstack-app
cd fullstack-app

mise use node@20
mise use go@1.21
mise use python@3.11  # Para scripts

# Crear estructura
mkdir backend frontend scripts
```

---

## 🐛 Solución de Problemas

### Mise no se activa automáticamente

**Problema**: Los comandos de mise no funcionan.

**Solución**:
```bash
# Verificar que mise está en el PATH
which mise

# Añadir activación al shell
echo 'eval "$(mise activate bash)"' >> ~/.bashrc
source ~/.bashrc

# O para Zsh
echo 'eval "$(mise activate zsh)"' >> ~/.zshrc
source ~/.zshrc
```

### Versión no se encuentra

**Problema**: `mise use node@20` falla.

**Solución**:
```bash
# Ver versiones disponibles
mise ls-remote node

# Usar versión exacta
mise use node@20.10.0
```

### Conflicto con otras herramientas

**Problema**: Conflicto con nvm, rbenv, pyenv, etc.

**Solución**:
```bash
# Desactivar otras herramientas en ~/.bashrc o ~/.zshrc
# Comentar líneas de nvm, rbenv, pyenv

# Migrar versiones a mise
mise use --global node@$(node --version)
mise use --global ruby@$(ruby --version | cut -d' ' -f2)
```

### Permisos

**Problema**: Error de permisos al instalar herramientas.

**Solución**:
```bash
# Mise instala en ~/.local/share/mise
# No requiere sudo

# Verificar permisos
ls -la ~/.local/share/mise

# Si hay problemas, reinstalar mise
sudo apt remove mise
sudo apt install mise
```

---

## 📊 Comparación con Otras Herramientas

| Característica | Mise | asdf | nvm | rbenv |
|---------------|------|------|-----|-------|
| Velocidad | ⚡⚡⚡ | ⚡ | ⚡⚡ | ⚡⚡ |
| Múltiples lenguajes | ✅ | ✅ | ❌ | ❌ |
| Escrito en | Rust | Shell | Shell | Shell |
| Activación automática | ✅ | ✅ | ❌ | ✅ |
| Variables de entorno | ✅ | ❌ | ❌ | ❌ |
| Compatible con .tool-versions | ✅ | ✅ | ❌ | ❌ |

---

## 🎯 Mejores Prácticas

### 1. Usar Versiones Específicas en Proyectos

```bash
# ❌ Evitar
mise use node@latest

# ✅ Mejor
mise use node@20.10.0
```

### 2. Commitear `.tool-versions`

```bash
# Añadir al repositorio
git add .tool-versions
git commit -m "Add tool versions"
```

### 3. Documentar en README

```markdown
## Requisitos

Este proyecto usa [Mise](https://mise.jdx.dev/) para gestionar versiones:

\`\`\`bash
# Instalar Mise
curl https://mise.run | sh

# Instalar dependencias
mise install
\`\`\`
```

### 4. Usar Archivo de Configuración

```bash
# Crear .mise.toml para configuración avanzada
cat > .mise.toml << 'EOF'
[tools]
node = "20.10.0"
python = "3.11.5"

[env]
NODE_ENV = "development"
EOF
```

---

## 🔗 Enlaces Útiles

- **Sitio Oficial**: https://mise.jdx.dev/
- **Documentación**: https://mise.jdx.dev/getting-started.html
- **GitHub**: https://github.com/jdx/mise
- **Registro de Herramientas**: https://mise.jdx.dev/registry.html

---

## 📝 Comandos de Referencia Rápida

```bash
# Instalación
mise use --global node@20        # Instalar globalmente
mise use ruby@3.2                 # Instalar en proyecto

# Gestión
mise list                         # Ver instaladas
mise ls-remote node               # Ver disponibles
mise upgrade                      # Actualizar todas
mise uninstall node@18            # Desinstalar

# Información
mise current                      # Ver versiones actuales
mise where node                   # Ver ubicación
mise --version                    # Ver versión de Mise

# Proyecto
mise install                      # Instalar desde .tool-versions
mise exec -- node script.js       # Ejecutar con versión del proyecto
```

---

## ✨ Integración con DevDeb

### Script de Instalación

DevDeb incluye un script para instalar Mise:

```bash
# Ubicación
~/Workspace/Repositorios/Instalación/devdeb/scripts/tools/mise.sh

# Ejecutar
./scripts/tools/mise.sh
```

### Selección de Lenguajes

DevDeb usa Mise para instalar lenguajes:

```bash
# Script de selección
./scripts/dev/select-dev-language.sh

# Instala lenguajes usando Mise automáticamente
```

---

**¡Disfruta de Mise en tu entorno DevDeb! 🚀**
