# Guía Rápida: Configurar Mise en Zsh

## 🎯 Para Usuarios de Zsh

Si usas **zsh** en lugar de bash, aquí está todo lo que necesitas saber para configurar mise correctamente.

---

## 📋 Instalación

### Paso 1: Instalar Mise

```bash
cd ~/Workspace/Repositorios/Instalación/devdeb
./mise.sh
```

Esto instala mise en tu sistema (funciona igual para bash y zsh).

---

## ⚙️ Configuración para Zsh

### Paso 2: Activar Mise en Zsh

**Diferencia clave**: En zsh usas `zsh` en lugar de `bash`:

```bash
# Añadir a ~/.zshrc
echo 'eval "$(mise activate zsh)"' >> ~/.zshrc

# Recargar configuración
source ~/.zshrc
```

### Verificar que Funciona

```bash
# Verificar versión
mise --version

# Debería mostrar algo como: mise 2024.x.x
```

---

## 🚀 Uso Básico

### Instalar Lenguajes

```bash
# Node.js
mise use --global node@20

# Ruby
mise use --global ruby@3.2

# Python
mise use --global python@3.11

# Go
mise use --global go@1.21
```

### Comandos Útiles

```bash
# Ver qué está instalado
mise list

# Ver versiones disponibles
mise ls-remote node

# Actualizar herramientas
mise upgrade
```

---

## 🔧 Configuración Avanzada (Opcional)

### Autocompletado en Zsh

Mise incluye autocompletado para zsh:

```bash
# Añadir a ~/.zshrc (después de la línea de activación)
echo 'eval "$(mise completion zsh)"' >> ~/.zshrc
source ~/.zshrc
```

Ahora puedes presionar `Tab` para autocompletar comandos de mise.

### Alias Útiles

Añade estos a tu `~/.zshrc`:

```bash
# Alias para mise
alias mi='mise'
alias mil='mise list'
alias miu='mise use'
alias mir='mise ls-remote'
```

---

## 📝 Diferencias Bash vs Zsh

| Aspecto | Bash | Zsh |
|---------|------|-----|
| Archivo de config | `~/.bashrc` | `~/.zshrc` |
| Comando de activación | `mise activate bash` | `mise activate zsh` |
| Autocompletado | `mise completion bash` | `mise completion zsh` |
| Todo lo demás | ✅ Igual | ✅ Igual |

---

## ⚠️ Nota sobre a-shell.sh

El script `a-shell.sh` de devdeb está configurado para **bash**, no para zsh.

Si usas zsh, tienes dos opciones:

### Opción 1: Configuración Manual (Recomendado)

```bash
# Añadir mise a tu ~/.zshrc manualmente
echo 'eval "$(mise activate zsh)"' >> ~/.zshrc
source ~/.zshrc
```

### Opción 2: Crear a-shell-zsh.sh

Puedes crear un script equivalente para zsh si lo necesitas.

---

## ✅ Checklist de Configuración

- [ ] Ejecutar `./mise.sh` para instalar mise
- [ ] Añadir `eval "$(mise activate zsh)"` a `~/.zshrc`
- [ ] Ejecutar `source ~/.zshrc`
- [ ] Verificar con `mise --version`
- [ ] (Opcional) Añadir autocompletado
- [ ] (Opcional) Añadir aliases

---

## 🎉 ¡Listo!

Ahora puedes usar mise en zsh exactamente igual que en bash.

### Ejemplo Completo

```bash
# 1. Instalar mise
cd ~/Workspace/Repositorios/Instalación/devdeb
./mise.sh

# 2. Configurar zsh
echo 'eval "$(mise activate zsh)"' >> ~/.zshrc
source ~/.zshrc

# 3. Instalar Node.js
mise use --global node@20

# 4. Verificar
node --version
```

---

## 📚 Más Información

- **Documentación oficial**: https://mise.jdx.dev/
- **Compatibilidad Debian**: [COMPATIBILIDAD_MISE.md](COMPATIBILIDAD_MISE.md)
- **Script de instalación**: [mise.sh](mise.sh)
