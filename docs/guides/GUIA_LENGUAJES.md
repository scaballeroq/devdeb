# Guía de Instalación de Lenguajes de Programación - DevDeb

## 📋 Descripción

El script `select-dev-language.sh` te permite instalar de forma interactiva múltiples lenguajes de programación en tu sistema Debian 13 usando **Mise** como gestor de versiones.

### ¿Qué hace este script?

✅ Presenta un menú interactivo con 8 lenguajes de programación  
✅ Permite seleccionar múltiples lenguajes a la vez  
✅ Instala automáticamente las últimas versiones usando Mise  
✅ Configura dependencias específicas de cada lenguaje  
✅ Instala herramientas adicionales (Rails, Composer, etc.)

---

## 🚀 Uso Rápido

### Ejecución del Script

```bash
# Desde el directorio de DevDeb
cd ~/Workspace/Repositorios/Instalación/devdeb
./scripts/dev/select-dev-language.sh
```

### Interfaz Interactiva

El script mostrará un menú como este:

```
Selecciona los lenguajes de programación a instalar:
  [ ] Ruby on Rails
  [ ] Node.js
  [ ] Go
  [ ] PHP
  [ ] Python
  [ ] Elixir
  [ ] Rust
  [ ] Java
```

**Controles:**
- `Espacio` - Seleccionar/deseleccionar lenguaje
- `Enter` - Confirmar selección e instalar
- `Flechas` - Navegar por el menú

---

## 📦 Lenguajes Disponibles

### 1. Ruby on Rails 💎

**¿Qué se instala?**
- Ruby (última versión estable)
- RubyGems (gestor de paquetes)
- Rails (framework web)

**Instalación:**
```bash
# El script ejecuta:
mise use --global ruby@latest
mise exec ruby -- gem install rails --no-document
```

**Verificar:**
```bash
ruby --version
rails --version
gem --version
```

**Uso básico:**
```bash
# Crear nueva aplicación Rails
rails new mi-app
cd mi-app
rails server
```

---

### 2. Node.js 🟢

**¿Qué se instala?**
- Node.js LTS (Long Term Support)
- npm (gestor de paquetes)

**Instalación:**
```bash
# El script ejecuta:
mise use --global node@lts
```

**Verificar:**
```bash
node --version
npm --version
```

**Uso básico:**
```bash
# Crear proyecto
mkdir mi-proyecto
cd mi-proyecto
npm init -y

# Instalar dependencias
npm install express

# Crear servidor simple
cat > index.js << 'EOF'
const express = require('express');
const app = express();
app.get('/', (req, res) => res.send('¡Hola!'));
app.listen(3000, () => console.log('Servidor en puerto 3000'));
EOF

# Ejecutar
node index.js
```

---

### 3. Go 🐹

**¿Qué se instala?**
- Go (última versión estable)
- Herramientas de compilación

**Instalación:**
```bash
# El script ejecuta:
mise use --global go@latest
```

**Verificar:**
```bash
go version
```

**Uso básico:**
```bash
# Crear módulo
mkdir mi-app
cd mi-app
go mod init ejemplo.com/mi-app

# Crear programa
cat > main.go << 'EOF'
package main
import "fmt"
func main() {
    fmt.Println("¡Hola desde Go!")
}
EOF

# Ejecutar
go run main.go

# Compilar
go build
./mi-app
```

---

### 4. PHP 🐘

**¿Qué se instala?**
- PHP (última versión)
- Extensiones: curl, mysql, redis, xml, mbstring, zip
- Composer (gestor de dependencias)

**Instalación:**
```bash
# El script ejecuta:
mise use --global php@latest

# Instala extensiones
sudo apt install -y php-curl php-mysql php-redis php-xml php-mbstring php-zip

# Instala Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
```

**Verificar:**
```bash
php --version
composer --version
```

**Uso básico:**
```bash
# Crear proyecto
mkdir mi-proyecto
cd mi-proyecto

# Inicializar Composer
composer init --no-interaction

# Instalar dependencias
composer require monolog/monolog

# Crear script PHP
cat > index.php << 'EOF'
<?php
require 'vendor/autoload.php';
use Monolog\Logger;
echo "¡Hola desde PHP!\n";
EOF

# Ejecutar
php index.php

# Servidor de desarrollo
php -S localhost:8000
```

---

### 5. Python 🐍

**¿Qué se instala?**
- Python (última versión)
- pip (gestor de paquetes)
- venv (entornos virtuales)

**Instalación:**
```bash
# El script ejecuta:
mise use --global python@latest
```

**Verificar:**
```bash
python --version
pip --version
```

**Uso básico:**
```bash
# Crear entorno virtual
python -m venv venv
source venv/bin/activate

# Instalar dependencias
pip install requests flask

# Crear aplicación
cat > app.py << 'EOF'
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return '¡Hola desde Python!'

if __name__ == '__main__':
    app.run(debug=True)
EOF

# Ejecutar
python app.py
```

---

### 6. Elixir 💧

**¿Qué se instala?**
- Erlang (runtime necesario)
- Elixir (lenguaje)
- Hex (gestor de paquetes)

**Instalación:**
```bash
# El script ejecuta:
mise use --global erlang@latest
mise use --global elixir@latest
mise exec elixir -- mix local.hex --force
```

**Verificar:**
```bash
elixir --version
erl -version
mix --version
```

**Uso básico:**
```bash
# Crear proyecto
mix new mi_app
cd mi_app

# Ejecutar tests
mix test

# Iniciar consola interactiva
iex -S mix

# Compilar
mix compile
```

---

### 7. Rust 🦀

**¿Qué se instala?**
- Rust (última versión)
- Cargo (gestor de paquetes y build)
- rustc (compilador)

**Instalación:**
```bash
# El script ejecuta:
mise use --global rust@latest
```

**Verificar:**
```bash
rustc --version
cargo --version
```

**Uso básico:**
```bash
# Crear proyecto
cargo new mi-proyecto
cd mi-proyecto

# Editar src/main.rs
cat > src/main.rs << 'EOF'
fn main() {
    println!("¡Hola desde Rust!");
}
EOF

# Compilar y ejecutar
cargo run

# Solo compilar
cargo build

# Compilar optimizado
cargo build --release
```

---

### 8. Java ☕

**¿Qué se instala?**
- OpenJDK (última versión)
- JRE (Java Runtime Environment)
- JDK (Java Development Kit)

**Instalación:**
```bash
# El script ejecuta:
mise use --global java@latest
```

**Verificar:**
```bash
java --version
javac --version
```

**Uso básico:**
```bash
# Crear programa
cat > HolaMundo.java << 'EOF'
public class HolaMundo {
    public static void main(String[] args) {
        System.out.println("¡Hola desde Java!");
    }
}
EOF

# Compilar
javac HolaMundo.java

# Ejecutar
java HolaMundo
```

---

## 🔧 Requisitos Previos

### 1. Mise Instalado

El script requiere que **Mise** esté instalado y configurado:

```bash
# Instalar Mise
./scripts/tools/mise.sh

# Activar en tu shell
echo 'eval "$(mise activate bash)"' >> ~/.bashrc
source ~/.bashrc

# O para Zsh
echo 'eval "$(mise activate zsh)"' >> ~/.zshrc
source ~/.zshrc

# Verificar
mise --version
```

### 2. Dependencias del Sistema

```bash
# Actualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar dependencias básicas
sudo apt install -y build-essential curl wget git
```

---

## 📝 Funcionamiento Interno

### Flujo del Script

1. **Verificación de Mise**
   - Comprueba que Mise esté instalado
   - Si no está, muestra error y sale

2. **Menú Interactivo**
   - Usa `gum` para mostrar menú de selección múltiple
   - Permite elegir uno o más lenguajes

3. **Instalación Secuencial**
   - Instala cada lenguaje seleccionado
   - Muestra progreso en tiempo real
   - Configura dependencias adicionales

4. **Verificación**
   - Comprueba que cada lenguaje se instaló correctamente
   - Muestra versiones instaladas

### Variables de Entorno

El script usa variables de entorno de DevDeb:

```bash
# Almacena la selección del usuario
DEVDEB_FIRST_RUN_LANGUAGES="ruby,node,python"
```

---

## 💡 Ejemplos de Uso

### Instalar un Solo Lenguaje

```bash
# Ejecutar script
./scripts/dev/select-dev-language.sh

# Seleccionar solo Node.js
# Presionar Espacio en Node.js
# Presionar Enter
```

### Instalar Múltiples Lenguajes

```bash
# Ejecutar script
./scripts/dev/select-dev-language.sh

# Seleccionar varios:
# - Espacio en Ruby on Rails
# - Espacio en Node.js
# - Espacio en Python
# - Enter para confirmar
```

### Stack Completo de Desarrollo Web

```bash
# Instalar stack MERN (MongoDB, Express, React, Node)
# Seleccionar:
# - Node.js (para backend y frontend)
# - Python (para scripts)

# Luego instalar MongoDB con Docker:
docker run -d --name mongodb -p 27017:27017 mongo
```

### Stack de Data Science

```bash
# Instalar stack de ciencia de datos
# Seleccionar:
# - Python (pandas, numpy, jupyter)
# - R (si se añade al script)

# Luego instalar paquetes Python:
pip install pandas numpy matplotlib jupyter
```

---

## 🐛 Solución de Problemas

### Error: "mise: command not found"

**Problema**: Mise no está instalado o no está en el PATH.

**Solución**:
```bash
# Instalar Mise
./scripts/tools/mise.sh

# Activar en shell
eval "$(mise activate bash)"

# Añadir a ~/.bashrc permanentemente
echo 'eval "$(mise activate bash)"' >> ~/.bashrc
```

### Error: "gum: command not found"

**Problema**: La herramienta `gum` no está instalada.

**Solución**:
```bash
# Instalar gum
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudo apt install -y gum
```

### Error al Instalar PHP

**Problema**: Extensiones de PHP no se encuentran.

**Solución**:
```bash
# Añadir repositorio de PHP
sudo apt install -y software-properties-common
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update

# Instalar PHP y extensiones
sudo apt install -y php8.2 php8.2-{curl,mysql,redis,xml,mbstring,zip}
```

### Error al Instalar Elixir

**Problema**: Erlang no se instala correctamente.

**Solución**:
```bash
# Instalar Erlang manualmente
sudo apt install -y erlang

# Luego instalar Elixir con Mise
mise use --global elixir@latest
```

### Versión Incorrecta Instalada

**Problema**: Se instaló una versión diferente a la esperada.

**Solución**:
```bash
# Ver versiones disponibles
mise ls-remote node

# Instalar versión específica
mise use --global node@20.10.0

# Verificar
node --version
```

---

## 🎯 Mejores Prácticas

### 1. Instalar Solo lo Necesario

```bash
# ❌ Evitar instalar todos los lenguajes
# Solo instala los que realmente necesitas

# ✅ Mejor
# Selecciona solo Node.js y Python si solo los necesitas
```

### 2. Usar Versiones Específicas en Proyectos

```bash
# Después de instalar globalmente
cd mi-proyecto

# Especificar versión para este proyecto
mise use node@20.10.0
mise use python@3.11.5

# Esto crea .tool-versions
cat .tool-versions
```

### 3. Documentar Dependencias

```bash
# En el README.md de tu proyecto
cat >> README.md << 'EOF'
## Requisitos

- Node.js 20.x
- Python 3.11.x

Instalar con Mise:
```bash
mise install
```
EOF
```

### 4. Mantener Actualizado

```bash
# Actualizar todos los lenguajes instalados
mise upgrade

# Actualizar uno específico
mise upgrade node
```

---

## 🔄 Gestión Post-Instalación

### Ver Lenguajes Instalados

```bash
# Listar todas las herramientas instaladas
mise list

# Ver versión actual de un lenguaje
mise current node
mise current python
```

### Cambiar Versiones

```bash
# Cambiar versión global
mise use --global node@18

# Cambiar versión en proyecto
cd mi-proyecto
mise use node@20
```

### Desinstalar Lenguajes

```bash
# Desinstalar versión específica
mise uninstall node@18

# Ver qué versiones están instaladas
mise list node
```

---

## 📚 Recursos Adicionales

### Documentación de Lenguajes

- **Ruby**: https://www.ruby-lang.org/
- **Node.js**: https://nodejs.org/
- **Go**: https://go.dev/
- **PHP**: https://www.php.net/
- **Python**: https://www.python.org/
- **Elixir**: https://elixir-lang.org/
- **Rust**: https://www.rust-lang.org/
- **Java**: https://openjdk.org/

### Gestores de Paquetes

- **Ruby**: https://rubygems.org/
- **Node.js**: https://www.npmjs.com/
- **PHP**: https://getcomposer.org/
- **Python**: https://pypi.org/
- **Elixir**: https://hex.pm/
- **Rust**: https://crates.io/

### Frameworks Populares

- **Ruby**: Rails, Sinatra
- **Node.js**: Express, Next.js, NestJS
- **Go**: Gin, Echo, Fiber
- **PHP**: Laravel, Symfony
- **Python**: Django, Flask, FastAPI
- **Elixir**: Phoenix
- **Rust**: Actix, Rocket
- **Java**: Spring Boot, Quarkus

---

## 🚀 Proyectos de Ejemplo

### API REST con Node.js

```bash
# Instalar Node.js
./scripts/dev/select-dev-language.sh
# Seleccionar Node.js

# Crear proyecto
mkdir api-rest
cd api-rest
npm init -y
npm install express

# Crear API
cat > server.js << 'EOF'
const express = require('express');
const app = express();
app.use(express.json());

app.get('/api/users', (req, res) => {
  res.json([{ id: 1, name: 'Juan' }]);
});

app.listen(3000, () => console.log('API en puerto 3000'));
EOF

# Ejecutar
node server.js
```

### Web App con Python/Flask

```bash
# Instalar Python
./scripts/dev/select-dev-language.sh
# Seleccionar Python

# Crear proyecto
mkdir webapp
cd webapp
python -m venv venv
source venv/bin/activate
pip install flask

# Crear app
cat > app.py << 'EOF'
from flask import Flask, render_template
app = Flask(__name__)

@app.route('/')
def home():
    return '<h1>¡Hola desde Flask!</h1>'

if __name__ == '__main__':
    app.run(debug=True, port=5000)
EOF

# Ejecutar
python app.py
```

### CLI Tool con Go

```bash
# Instalar Go
./scripts/dev/select-dev-language.sh
# Seleccionar Go

# Crear proyecto
mkdir cli-tool
cd cli-tool
go mod init ejemplo.com/cli-tool

# Crear herramienta
cat > main.go << 'EOF'
package main
import (
    "fmt"
    "os"
)

func main() {
    if len(os.Args) < 2 {
        fmt.Println("Uso: ./cli-tool <nombre>")
        return
    }
    fmt.Printf("¡Hola, %s!\n", os.Args[1])
}
EOF

# Compilar
go build

# Ejecutar
./cli-tool Juan
```

---

## ✅ Checklist de Instalación

Después de ejecutar el script, verifica:

- [ ] Mise está instalado y activado
- [ ] Los lenguajes seleccionados se instalaron correctamente
- [ ] Puedes ejecutar comandos de cada lenguaje
- [ ] Las versiones son las esperadas
- [ ] Los gestores de paquetes funcionan (npm, pip, gem, etc.)
- [ ] Puedes crear y ejecutar proyectos de prueba

---

**¡Disfruta programando en múltiples lenguajes con DevDeb! 🚀**
