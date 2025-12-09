# Directorio de Fuentes

Este directorio está destinado para almacenar fuentes adicionales que quieras instalar en tu sistema.

## 📁 Estructura

```
assets/fonts/
├── README.md          # Este archivo
└── [tus fuentes]      # Archivos .ttf, .otf
```

## 🎯 Uso

1. **Añadir fuentes**: Copia tus archivos de fuentes (.ttf, .otf) a este directorio

2. **Instalar fuentes**: Ejecuta el script de instalación
   ```bash
   ./scripts/setup/install-fonts.sh
   ```

3. El script automáticamente:
   - Detectará las fuentes en este directorio
   - Las copiará a `~/.local/share/fonts/Custom/`
   - Las organizará por nombre de fuente
   - Actualizará el caché del sistema

## 📦 Fuentes Recomendadas

El script `install-fonts.sh` descarga e instala automáticamente:

- **JetBrains Mono Nerd Font** - Excelente para programación
- **Fira Code Nerd Font** - Con ligaduras hermosas
- **Cascadia Code Nerd Font** - Moderna de Microsoft
- **Meslo Nerd Font** - Recomendada por Powerlevel10k
- **Hack Nerd Font** - Diseñada para código

## 🔗 Descargar Más Fuentes

- **Nerd Fonts**: https://www.nerdfonts.com/
- **Google Fonts**: https://fonts.google.com/
- **Font Squirrel**: https://www.fontsquirrel.com/

## 💡 Ejemplo

```bash
# Descargar una fuente
cd assets/fonts
wget https://ejemplo.com/fuente.ttf

# Instalar todas las fuentes
cd ../..
./scripts/setup/install-fonts.sh
```
