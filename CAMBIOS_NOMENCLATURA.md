# Cambios de Nomenclatura: OMAKUB → DEVDEB

## 📝 Resumen

Se han reemplazado todas las referencias a variables de entorno con prefijo `OMAKUB_` por `DEVDEB_` en todos los scripts de devdeb.

---

## ✅ Variables Renombradas

### Variables de Usuario

| Antes | Después |
|-------|---------|
| `OMAKUB_USER_NAME` | `DEVDEB_USER_NAME` |
| `OMAKUB_USER_EMAIL` | `DEVDEB_USER_EMAIL` |

**Uso**: Almacenan el nombre y email del usuario para configuración de Git.

**Archivo**: `identification.sh`

---

### Variables de Selección de Instalación

| Antes | Después |
|-------|---------|
| `OMAKUB_FIRST_RUN_OPTIONAL_APPS` | `DEVDEB_FIRST_RUN_OPTIONAL_APPS` |
| `OMAKUB_FIRST_RUN_LANGUAGES` | `DEVDEB_FIRST_RUN_LANGUAGES` |
| `OMAKUB_FIRST_RUN_DBS` | `DEVDEB_FIRST_RUN_DBS` |

**Uso**: Almacenan las selecciones del usuario durante la instalación inicial.

**Archivos**: 
- `first-run-choices.sh` (exporta las variables)
- `select-dev-language.sh` (lee DEVDEB_FIRST_RUN_LANGUAGES)
- `install.sh` (documentación)

---

### Variables de Configuración

| Antes | Después |
|-------|---------|
| `OMAKUB_REF` | `DEVDEB_REF` |

**Uso**: Especifica la rama o tag del repositorio a usar.

**Archivo**: `boot.sh`

---

## 📁 Archivos Modificados

### 1. **select-dev-language.sh**
**Cambios**: 3 referencias
- Comentario de documentación
- Verificación de variable
- Asignación de variable

```bash
# Antes
if [[ -v OMAKUB_FIRST_RUN_LANGUAGES ]]; then
  languages=$OMAKUB_FIRST_RUN_LANGUAGES

# Después
if [[ -v DEVDEB_FIRST_RUN_LANGUAGES ]]; then
  languages=$DEVDEB_FIRST_RUN_LANGUAGES
```

---

### 2. **identification.sh**
**Cambios**: 4 referencias
- 2 comentarios de documentación
- 2 exports de variables

```bash
# Antes
export OMAKUB_USER_NAME=$(gum input ...)
export OMAKUB_USER_EMAIL=$(gum input ...)

# Después
export DEVDEB_USER_NAME=$(gum input ...)
export DEVDEB_USER_EMAIL=$(gum input ...)
```

---

### 3. **first-run-choices.sh**
**Cambios**: 7 referencias
- 3 comentarios de documentación
- 3 exports de variables

```bash
# Antes
export OMAKUB_FIRST_RUN_OPTIONAL_APPS=$(gum choose ...)
export OMAKUB_FIRST_RUN_LANGUAGES=$(gum choose ...)
export OMAKUB_FIRST_RUN_DBS=$(gum choose ...)

# Después
export DEVDEB_FIRST_RUN_OPTIONAL_APPS=$(gum choose ...)
export DEVDEB_FIRST_RUN_LANGUAGES=$(gum choose ...)
export DEVDEB_FIRST_RUN_DBS=$(gum choose ...)
```

---

### 4. **install.sh**
**Cambios**: 5 referencias (solo en comentarios de documentación)
- Documentación de variables de entorno

```bash
# Antes
#   OMAKUB_FIRST_RUN_OPTIONAL_APPS: Apps opcionales seleccionadas
#   OMAKUB_FIRST_RUN_LANGUAGES: Lenguajes de programación seleccionados
#   OMAKUB_FIRST_RUN_DBS: Bases de datos seleccionadas
#   OMAKUB_USER_NAME: Nombre completo del usuario
#   OMAKUB_USER_EMAIL: Email del usuario

# Después
#   DEVDEB_FIRST_RUN_OPTIONAL_APPS: Apps opcionales seleccionadas
#   DEVDEB_FIRST_RUN_LANGUAGES: Lenguajes de programación seleccionados
#   DEVDEB_FIRST_RUN_DBS: Bases de datos seleccionadas
#   DEVDEB_USER_NAME: Nombre completo del usuario
#   DEVDEB_USER_EMAIL: Email del usuario
```

---

### 5. **boot.sh**
**Cambios**: 4 referencias
- 2 comentarios de documentación
- 2 usos de variable

```bash
# Antes
if [[ $OMAKUB_REF != "master" ]]; then
  git fetch origin "${OMAKUB_REF:-stable}" && git checkout "${OMAKUB_REF:-stable}"

# Después
if [[ $DEVDEB_REF != "master" ]]; then
  git fetch origin "${DEVDEB_REF:-stable}" && git checkout "${DEVDEB_REF:-stable}"
```

---

## 📊 Estadísticas

| Archivo | Referencias Cambiadas |
|---------|----------------------|
| select-dev-language.sh | 3 |
| identification.sh | 4 |
| first-run-choices.sh | 7 |
| install.sh | 5 |
| boot.sh | 4 |
| **TOTAL** | **23** |

---

## ✅ Verificación

### Comprobar que no quedan referencias a OMAKUB

```bash
cd ~/Workspace/Repositorios/Instalación/devdeb
grep -r "OMAKUB" *.sh

# No debería devolver resultados en variables
# Solo puede aparecer en comentarios que hablen de Omakub como proyecto
```

### Verificar nuevas variables DEVDEB

```bash
grep -r "DEVDEB" *.sh

# Debería mostrar todas las nuevas variables
```

---

## 🎯 Impacto

### Compatibilidad

**⚠️ IMPORTANTE**: Este cambio **NO es compatible** con scripts que esperen variables `OMAKUB_*`.

Si tienes scripts personalizados que usan las variables antiguas, deberás actualizarlos.

### Migración

Si estás migrando de Omakub a DevDeb:

```bash
# Opción 1: Crear aliases temporales
export OMAKUB_USER_NAME="$DEVDEB_USER_NAME"
export OMAKUB_USER_EMAIL="$DEVDEB_USER_EMAIL"
# etc...

# Opción 2: Actualizar tus scripts para usar DEVDEB_*
sed -i 's/OMAKUB_/DEVDEB_/g' tus_scripts.sh
```

---

## 💡 Razón del Cambio

Este cambio hace que DevDeb sea **completamente independiente** de Omakub en:

1. ✅ **Nomenclatura** - Variables propias
2. ✅ **Funcionalidad** - Scripts independientes
3. ✅ **Configuración** - Archivos propios en `configs/`
4. ✅ **Identidad** - Proyecto separado

---

## 🔄 Uso de las Variables

### Durante la Instalación

```bash
# El usuario ejecuta
./install.sh

# El script pregunta nombre y email
# Y exporta:
export DEVDEB_USER_NAME="Juan Pérez"
export DEVDEB_USER_EMAIL="juan@example.com"

# Luego pregunta qué instalar
# Y exporta:
export DEVDEB_FIRST_RUN_LANGUAGES="Ruby on Rails,Node.js"
export DEVDEB_FIRST_RUN_DBS="MySQL,Redis"

# Scripts posteriores leen estas variables
# Para instalar solo lo seleccionado
```

### Especificar Rama

```bash
# Usar rama específica
DEVDEB_REF=develop ./boot.sh

# O usar tag específico
DEVDEB_REF=v1.0.0 ./boot.sh
```

---

## ✅ Conclusión

**Estado**: ✅ Completado

Todas las referencias a `OMAKUB_*` han sido reemplazadas por `DEVDEB_*` en los archivos `.sh` de devdeb.

El proyecto DevDeb ahora tiene su propia identidad de variables de entorno, completamente separada de Omakub.
