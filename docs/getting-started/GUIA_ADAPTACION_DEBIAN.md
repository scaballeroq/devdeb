# Guía de Adaptación de Omakub para Debian 13 Trixie

## 🎯 Objetivo

Esta guía explica cómo adaptar los scripts de Omakub (diseñados para Ubuntu 24.04+) para que funcionen correctamente en Debian 13 (Trixie).

---

## 📋 Cambios Necesarios por Script

### 1. `check-version.sh` - CRÍTICO ⚠️

**Problema**: Verifica que el sistema sea Ubuntu 24.04+

**Solución**: Modificar la verificación para aceptar Debian 13+

```bash
# ORIGINAL (líneas 12-18)
if [ "$ID" != "ubuntu" ] || [ $(echo "$VERSION_ID >= 24.04" | bc) != 1 ]; then
  echo "$(tput setaf 1)Error: OS requirement not met"
  echo "You are currently running: $ID $VERSION_ID"
  echo "OS required: Ubuntu 24.04 or higher"
  echo "Installation stopped."
  exit 1
fi

# ADAPTADO PARA DEBIAN
if [ "$ID" != "debian" ]; then
  echo "$(tput setaf 1)Error: OS requirement not met"
  echo "You are currently running: $ID $VERSION_ID"
  echo "OS required: Debian 13 (Trixie) or higher"
  echo "Installation stopped."
  exit 1
fi

# Verificar versión solo si VERSION_ID está definido
# En Debian testing, VERSION_ID puede no existir
if [ -n "$VERSION_ID" ] && [ $(echo "$VERSION_ID >= 13" | bc) != 1 ]; then
  echo "$(tput setaf 1)Error: Debian version too old"
  echo "You are currently running: Debian $VERSION_ID"
  echo "Version required: Debian 13 (Trixie) or higher"
  echo "Installation stopped."
  exit 1
fi
```

---

### 2. `docker.sh` - IMPORTANTE 🔧

**Problema**: Usa repositorios de Ubuntu

**Solución**: Cambiar URLs a repositorios de Debian

```bash
# ORIGINAL (línea 7)
sudo wget -qO /etc/apt/keyrings/docker.asc https://download.docker.com/linux/ubuntu/gpg

# ADAPTADO
sudo wget -qO /etc/apt/keyrings/docker.asc https://download.docker.com/linux/debian/gpg

# ORIGINAL (línea 9)
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

# ADAPTADO
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
```

**Nota**: Si `VERSION_CODENAME` no está definido en Debian testing, usar explícitamente:
```bash
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian trixie stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
```

---

### 3. `app-chrome.sh` - FUNCIONA ✅

**Estado**: No requiere cambios

Chrome usa el mismo repositorio para todas las distribuciones Debian-based.

---

### 4. `app-vscode.sh` - FUNCIONA ✅

**Estado**: No requiere cambios

VSCode usa el mismo repositorio para todas las distribuciones Debian-based.

---

### 5. `app-signal.sh` - VERIFICAR 🔍

**Problema potencial**: Puede usar repositorio específico de Ubuntu

**Solución**: Verificar que use repositorio genérico o adaptarlo

```bash
# Si usa repositorio específico de Ubuntu, cambiar a:
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee /etc/apt/sources.list.d/signal-xenial.list
```

---

### 6. `mise.sh` - FUNCIONA ✅

**Estado**: No requiere cambios

Mise soporta Debian directamente.

---

### 7. Scripts de GNOME - VERIFICAR 🔍

**Problema potencial**: Versiones de GNOME pueden diferir

**Solución**: Verificar versión de GNOME en Debian

```bash
# Verificar versión de GNOME
gnome-shell --version
```

**Adaptaciones posibles**:
- Algunas extensiones pueden no ser compatibles
- Algunos gsettings pueden tener nombres diferentes
- Verificar disponibilidad de cada extensión

---

### 8. Fuentes - FUNCIONA ✅

**Estado**: No requiere cambios

Las Nerd Fonts se instalan de la misma manera.

---

## 🔄 Estrategia de Adaptación General

### Repositorios APT

Cuando un script añade un repositorio:

1. **Identificar el tipo de repositorio**:
   - ¿Es específico de Ubuntu?
   - ¿Tiene versión para Debian?
   - ¿Es genérico para Debian-based?

2. **Cambiar URL si es necesario**:
   ```bash
   # Ubuntu
   https://download.example.com/linux/ubuntu/
   
   # Debian
   https://download.example.com/linux/debian/
   ```

3. **Verificar VERSION_CODENAME**:
   ```bash
   # En Debian testing puede no existir
   # Usar nombre explícito si es necesario
   
   # Dinámico (preferido)
   $(. /etc/os-release && echo "$VERSION_CODENAME")
   
   # Explícito (si VERSION_CODENAME no existe)
   trixie
   ```

### Paquetes APT

Algunos paquetes pueden tener nombres diferentes:

| Ubuntu | Debian | Notas |
|--------|--------|-------|
| `build-essential` | `build-essential` | ✅ Mismo |
| `gnome-tweaks` | `gnome-tweaks` | ✅ Mismo |
| Algunos PPAs | No disponibles | ⚠️ Buscar alternativas |

### Verificación de Paquetes

Antes de instalar, verificar disponibilidad:

```bash
# Buscar paquete
apt search nombre_paquete

# Ver información
apt show nombre_paquete

# Ver versión disponible
apt policy nombre_paquete
```

---

## 🧪 Proceso de Prueba

### 1. Entorno de Prueba

**Recomendado**: Usar máquina virtual o contenedor

```bash
# Con Docker (si ya tienes Docker instalado)
docker run -it debian:trixie bash

# Con VirtualBox/QEMU
# Instalar Debian 13 Trixie en VM
```

### 2. Prueba por Componentes

**No ejecutar todo de una vez**. Probar en orden:

1. ✅ Scripts de verificación
2. ✅ Configuración de shell
3. ✅ Docker
4. ✅ Mise
5. ✅ Un lenguaje de programación
6. ✅ Una aplicación de terminal
7. ✅ Una aplicación de desktop
8. ✅ Configuración de GNOME

### 3. Registro de Errores

Crear un archivo de log:

```bash
# Ejecutar con logging
bash -x script.sh 2>&1 | tee install.log

# Buscar errores
grep -i error install.log
grep -i failed install.log
```

---

## 📝 Checklist de Adaptación

### Scripts Críticos (Deben adaptarse)

- [ ] `check-version.sh` - Verificación de Debian
- [ ] `docker.sh` - Repositorio de Debian
- [ ] Cualquier script que añada repositorios APT

### Scripts a Verificar

- [ ] `app-signal.sh` - Verificar repositorio
- [ ] Scripts de GNOME - Verificar compatibilidad de extensiones
- [ ] Scripts que usen PPAs - Buscar alternativas

### Scripts que Funcionan Sin Cambios

- [x] `mise.sh`
- [x] `app-chrome.sh`
- [x] `app-vscode.sh`
- [x] `app-neovim.sh`
- [x] `fonts.sh`
- [x] Mayoría de scripts de aplicaciones

---

## 🔧 Herramientas Útiles para Adaptación

### Verificar Distribución

```bash
# Ver información del sistema
cat /etc/os-release

# Ver solo ID
grep ^ID= /etc/os-release | cut -d= -f2

# Ver solo VERSION_ID
grep ^VERSION_ID= /etc/os-release | cut -d= -f2
```

### Buscar Paquetes Equivalentes

```bash
# Buscar paquete
apt search nombre

# Ver paquetes instalados
dpkg -l | grep nombre

# Ver archivos de un paquete
dpkg -L nombre_paquete
```

### Verificar Repositorios

```bash
# Ver repositorios configurados
cat /etc/apt/sources.list
ls /etc/apt/sources.list.d/

# Ver claves GPG
ls /etc/apt/keyrings/
```

---

## 🚨 Problemas Comunes y Soluciones

### Problema: "Package not found"

**Causa**: Paquete no existe en Debian o tiene nombre diferente

**Solución**:
```bash
# Buscar paquete similar
apt search nombre_aproximado

# Buscar en packages.debian.org
# https://packages.debian.org/
```

### Problema: "GPG error"

**Causa**: Clave GPG incorrecta o no encontrada

**Solución**:
```bash
# Eliminar clave antigua
sudo rm /etc/apt/keyrings/nombre.asc

# Volver a descargar
sudo wget -qO /etc/apt/keyrings/nombre.asc URL_CORRECTA
```

### Problema: "Release file not found"

**Causa**: VERSION_CODENAME incorrecto o repositorio no existe

**Solución**:
```bash
# Verificar VERSION_CODENAME
cat /etc/os-release | grep VERSION_CODENAME

# Si no existe, usar nombre explícito
# Cambiar $(. /etc/os-release && echo "$VERSION_CODENAME")
# Por: trixie
```

### Problema: Extensión de GNOME no compatible

**Causa**: Versión de GNOME diferente

**Solución**:
```bash
# Verificar versión de GNOME
gnome-shell --version

# Buscar extensión compatible
# https://extensions.gnome.org/
```

---

## 📚 Recursos Adicionales

### Documentación Oficial

- **Debian**: https://www.debian.org/doc/
- **Docker en Debian**: https://docs.docker.com/engine/install/debian/
- **Mise**: https://mise.jdx.dev/

### Repositorios de Paquetes

- **Debian Packages**: https://packages.debian.org/
- **Debian Backports**: https://backports.debian.org/

### Comunidad

- **Debian Forums**: https://forums.debian.net/
- **Debian Wiki**: https://wiki.debian.org/

---

## ✅ Resumen de Cambios Mínimos

Para hacer funcionar Omakub en Debian 13 Trixie, los cambios **mínimos esenciales** son:

1. **check-version.sh**: Cambiar verificación de Ubuntu a Debian
2. **docker.sh**: Cambiar URLs de repositorio a versión Debian
3. **Verificar**: Cualquier otro script que añada repositorios APT

El resto de scripts deberían funcionar sin cambios o con adaptaciones menores.

---

## 🎯 Próximos Pasos

1. **Crear fork del proyecto** para tus adaptaciones
2. **Modificar scripts críticos** según esta guía
3. **Probar en VM** antes de aplicar en sistema real
4. **Documentar cambios** adicionales que encuentres
5. **Compartir con la comunidad** tus adaptaciones

---

**¡Buena suerte con tu instalación en Debian! 🚀**
