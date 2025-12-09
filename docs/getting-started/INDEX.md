# DevDeb - Índice de Documentación

Bienvenido al proyecto **DevDeb**, una adaptación de DevDeb para Debian 13 Trixie.

## 📚 Documentación Disponible

### 🚀 Para Empezar

1. **[README.md](README.md)** - **EMPIEZA AQUÍ**
   - Guía completa del proyecto
   - Instalación rápida y modular
   - Descripción de todos los componentes
   - Comandos útiles
   - Solución de problemas
   - **Lectura estimada**: 30-40 minutos

### 📖 Referencias

2. **[CATALOGO_SCRIPTS.md](CATALOGO_SCRIPTS.md)** - Referencia Completa
   - Índice de todos los 182+ scripts
   - Organizado por categorías
   - Descripción de cada script
   - Tabla resumen
   - **Uso**: Consulta rápida

3. **[GUIA_ADAPTACION_DEBIAN.md](GUIA_ADAPTACION_DEBIAN.md)** - Adaptación a Debian
   - Cambios necesarios por script
   - Scripts críticos a modificar
   - Estrategia de adaptación
   - Proceso de prueba
   - Problemas comunes y soluciones
   - **Lectura estimada**: 20-30 minutos

4. **[GUIA_WEB2APP.md](GUIA_WEB2APP.md)** - Crear WebApps
   - Convertir sitios web en aplicaciones de escritorio
   - Ejemplos prácticos (Gmail, YouTube, ChatGPT, etc.)
   - Organizar apps en carpetas
   - Script de instalación masiva incluido
   - **Lectura estimada**: 15-20 minutos

5. **[DOCUMENTACION_FUNCTIONS.md](DOCUMENTACION_FUNCTIONS.md)** - Funciones de Bash
   - Documentación completa de `functions.sh`
   - Explicación paso a paso de cada función
   - web2app, app2folder, compress, y más
   - Ejemplos de uso y solución de problemas
   - **Lectura estimada**: 20-25 minutos

6. **[GUIA_NEOVIM.md](GUIA_NEOVIM.md)** - Instalación de Neovim + LazyVim
   - Instalación independiente de Neovim
   - Configuración completa de LazyVim
   - Atajos de teclado y comandos útiles
   - Personalización y solución de problemas
   - **Lectura estimada**: 25-30 minutos

7. **[GUIA_STARSHIP.md](GUIA_STARSHIP.md)** - Prompt Moderno
   - Instalación de Starship
   - Configuración y personalización
   - Compatible con Bash y Zsh
   - **Lectura estimada**: 10-15 minutos

8. **[GUIA_HERRAMIENTAS_MODERNAS.md](GUIA_HERRAMIENTAS_MODERNAS.md)** - Herramientas CLI
   - eza, bat, fzf, zoxide, ripgrep, fd
   - Instalación y configuración
   - Ejemplos de uso
   - **Lectura estimada**: 15-20 minutos

9. **[GUIA_MISE.md](GUIA_MISE.md)** - Gestor de Versiones Mise
   - Instalación y configuración de Mise
   - Gestión de versiones de lenguajes
   - Uso por proyecto y ejemplos prácticos
   - **Lectura estimada**: 20-25 minutos

10. **[GUIA_LENGUAJES.md](GUIA_LENGUAJES.md)** - Instalación de Lenguajes de Programación
    - Guía del script select-dev-language.sh
    - 8 lenguajes: Ruby, Node.js, Go, PHP, Python, Elixir, Rust, Java
    - Ejemplos de uso y proyectos de inicio
    - **Lectura estimada**: 30-35 minutos

11. **[GUIA_POST_INSTALACION.md](GUIA_POST_INSTALACION.md)** - Configuración Post-Instalación GNOME
    - Script automatizado de configuración inicial
    - Software esencial, codecs, temas y herramientas
    - Explicación detallada de cada componente
    - **Lectura estimada**: 25-30 minutos

9. **[COMPATIBILIDAD_ZSH.md](COMPATIBILIDAD_ZSH.md)** - Compatibilidad con Zsh
    - Análisis de todos los scripts
    - Guía para usuarios de Zsh
    - **Lectura estimada**: 15 minutos


### 💻 Scripts Ejecutables

11. **[functions.sh](functions.sh)** - Funciones de Bash/Zsh
12. **[install-webapps.sh](install-webapps.sh)** - Instalador de WebApps
13. **[install-neovim.sh](install-neovim.sh)** - Instalador de Neovim + LazyVim
14. **[install-starship.sh](install-starship.sh)** - Instalador de Starship
15. **[install-modern-tools.sh](install-modern-tools.sh)** - Herramientas CLI modernas

### 📝 Scripts Comentados

16. **[boot.sh](boot.sh)** - Script de arranque
17. **[install.sh](install.sh)** - Instalador principal
18. **[ascii.sh](ascii.sh)** - Logo ASCII
19. **[check-version.sh](check-version.sh)** - Verificación de SO
20. **[first-run-choices.sh](first-run-choices.sh)** - Selección interactiva
21. **[identification.sh](identification.sh)** - Identidad del usuario
22. **[a-shell.sh](a-shell.sh)** - Configuración de Bash
23. **[docker.sh](docker.sh)** - Instalación de Docker
24. **[mise.sh](mise.sh)** - Gestor de versiones
25. **[app-neovim.sh](app-neovim.sh)** - Neovim + LazyVim
26. **[select-dev-language.sh](select-dev-language.sh)** - Lenguajes de programación

---

## 🎯 Flujo de Trabajo Recomendado

### Para Usuarios Nuevos

```
1. Lee README.md (sección "Instalación Rápida")
   ↓
2. Revisa GUIA_ADAPTACION_DEBIAN.md (cambios críticos)
   ↓
3. Modifica check-version.sh y docker.sh
   ↓
4. Ejecuta instalación en VM de prueba
   ↓
5. Si funciona, aplica en sistema real
```

### Para Instalación Personalizada

```
1. Lee README.md (sección "Instalación Modular")
   ↓
2. Consulta CATALOGO_SCRIPTS.md (elige componentes)
   ↓
3. Lee scripts comentados de componentes elegidos
   ↓
4. Ejecuta solo los scripts necesarios
```

### Para Desarrollo/Contribución

```
1. Lee todos los documentos principales
   ↓
2. Estudia scripts comentados
   ↓
3. Consulta CATALOGO_SCRIPTS.md como referencia
   ↓
4. Sigue estructura existente para nuevos scripts
```

---

## 📊 Resumen de Contenido

| Documento | Páginas | Palabras | Tema Principal |
|-----------|---------|----------|----------------|
| README.md | ~30 | ~15,000 | Guía completa de uso |
| CATALOGO_SCRIPTS.md | ~20 | ~5,000 | Referencia de scripts |
| GUIA_ADAPTACION_DEBIAN.md | ~15 | ~5,000 | Adaptación a Debian |
| Scripts comentados (11) | ~15 | ~5,000 | Código explicado |
| **TOTAL** | **~80** | **~30,000** | - |

---

## 🔍 Búsqueda Rápida

### Por Tema

- **Instalación**: README.md → "Instalación Rápida"
- **Docker**: docker.sh, README.md → "Docker"
- **Lenguajes**: select-dev-language.sh, README.md → "Lenguajes"
- **GNOME**: CATALOGO_SCRIPTS.md → "Scripts de Desktop"
- **Temas**: README.md → "Temas Disponibles"
- **Problemas**: README.md → "Solución de Problemas"
- **Debian**: GUIA_ADAPTACION_DEBIAN.md

### Por Componente

- **Neovim**: app-neovim.sh, README.md
- **VSCode**: CATALOGO_SCRIPTS.md → "app-vscode.sh"
- **Alacritty**: CATALOGO_SCRIPTS.md → "app-alacritty.sh"
- **Mise**: mise.sh, README.md
- **Git**: CATALOGO_SCRIPTS.md → "set-git.sh"

---

## 📁 Estructura de Archivos

```
devdeb/
│
├── INDEX.md                       ← ESTE ARCHIVO
├── README.md                      ← GUÍA PRINCIPAL
├── CATALOGO_SCRIPTS.md            ← REFERENCIA
├── GUIA_ADAPTACION_DEBIAN.md      ← ADAPTACIÓN
│
├── Scripts de Arranque:
│   ├── boot.sh
│   ├── install.sh
│   └── ascii.sh
│
├── Scripts de Verificación:
│   ├── check-version.sh
│   ├── first-run-choices.sh
│   └── identification.sh
│
├── Scripts de Terminal:
│   ├── a-shell.sh
│   ├── docker.sh
│   ├── mise.sh
│   ├── app-neovim.sh
│   └── select-dev-language.sh
│
└── (Más scripts disponibles en proyecto DevDeb original)
```

---

## 🎓 Niveles de Lectura

### Nivel 1: Usuario Básico (30 min)
- ✅ README.md → Instalación Rápida
- ✅ README.md → Solución de Problemas
- ✅ GUIA_ADAPTACION_DEBIAN.md → Resumen de Cambios

### Nivel 2: Usuario Avanzado (2 horas)
- ✅ README.md completo
- ✅ GUIA_ADAPTACION_DEBIAN.md completo
- ✅ CATALOGO_SCRIPTS.md (consulta)
- ✅ Scripts comentados de interés

### Nivel 3: Desarrollador (4+ horas)
- ✅ Toda la documentación
- ✅ Todos los scripts comentados
- ✅ Análisis del código fuente original
- ✅ Pruebas y experimentación

---

## 💡 Consejos de Uso

### Lectura Eficiente

1. **No leas todo de una vez** - Usa como referencia
2. **Empieza por README.md** - Visión general
3. **Consulta CATALOGO_SCRIPTS.md** - Cuando busques algo específico
4. **Lee scripts comentados** - Cuando quieras entender el código

### Navegación

- Usa **Ctrl+F** para buscar en documentos
- Sigue los **enlaces internos** entre documentos
- Consulta el **índice** de cada documento
- Usa las **tablas de contenido**

### Aprendizaje

- **Experimenta en VM** antes de aplicar cambios
- **Lee comentarios** en scripts antes de ejecutar
- **Anota problemas** que encuentres
- **Documenta soluciones** que descubras

---

## 🔗 Enlaces Externos Útiles

### Proyecto Original
- **DevDeb**: https://devdeb.org
- **Repositorio**: https://github.com/basecamp/devdeb

### Herramientas Principales
- **Mise**: https://mise.jdx.dev/
- **LazyVim**: https://www.lazyvim.org/
- **Alacritty**: https://alacritty.org/
- **Docker**: https://docs.docker.com/

### Debian
- **Debian**: https://www.debian.org/
- **Paquetes**: https://packages.debian.org/
- **Wiki**: https://wiki.debian.org/

---

## ✅ Checklist de Inicio Rápido

Antes de empezar:

- [ ] He leído README.md (al menos "Instalación Rápida")
- [ ] He revisado GUIA_ADAPTACION_DEBIAN.md (cambios críticos)
- [ ] Tengo Debian 13 Trixie instalado
- [ ] Tengo conexión a internet
- [ ] Tengo acceso sudo
- [ ] He hecho respaldo de mis configuraciones actuales
- [ ] Tengo tiempo (30-60 minutos para instalación completa)

Durante la instalación:

- [ ] He modificado check-version.sh para Debian
- [ ] He modificado docker.sh para Debian
- [ ] He probado en VM (recomendado)
- [ ] Estoy anotando errores que encuentro

Después de la instalación:

- [ ] He reiniciado el sistema
- [ ] He verificado que todo funciona
- [ ] He personalizado según mis preferencias
- [ ] He documentado problemas y soluciones

---

## 📞 Soporte

### Documentación
- Consulta README.md → "Solución de Problemas"
- Revisa GUIA_ADAPTACION_DEBIAN.md → "Problemas Comunes"

### Comunidad
- Debian Forums: https://forums.debian.net/
- DevDeb Issues: https://github.com/basecamp/devdeb/issues

---

## 🎉 ¡Listo para Empezar!

Ahora que conoces toda la documentación disponible, puedes:

1. **Empezar con README.md** para instalación rápida
2. **Consultar CATALOGO_SCRIPTS.md** para componentes específicos
3. **Revisar GUIA_ADAPTACION_DEBIAN.md** para adaptaciones
4. **Leer scripts comentados** para entender el código

**¡Disfruta de tu nuevo entorno de desarrollo en Debian! 🚀**

---

*Última actualización: 2025-12-08*
