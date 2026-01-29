# Compilar ROCKNIX para Raspberry Pi 5

Esta guía explica cómo compilar una imagen de ROCKNIX para la Raspberry Pi 5.

## Requisitos Previos

### Requisitos del Sistema

- Un sistema basado en Linux (Ubuntu 20.04 o más reciente recomendado)
- Al menos 100GB de espacio libre en disco
- Al menos 16GB de RAM (32GB recomendado para compilaciones más rápidas)
- Múltiples núcleos de CPU (las compilaciones se paralelizan)
- Conexión a internet estable

### Dependencias Requeridas

En sistemas Ubuntu/Debian, necesitarás instalar varias dependencias de compilación. El sistema de compilación verificará las dependencias faltantes y proporcionará instrucciones de instalación.

Las dependencias comunes incluyen:
- gcc, g++, make
- git
- xsltproc, xmlstarstar
- gperf
- Varias herramientas de procesamiento de fuentes e imágenes

## Métodos de Compilación

### Método 1: Usando Docker (Recomendado)

Docker es la forma más fácil y confiable de compilar ROCKNIX, ya que proporciona un entorno de compilación consistente.

#### 1. Instalar Docker

```bash
# Para Ubuntu/Debian
sudo apt update
sudo apt install docker.io
sudo usermod -aG docker $USER
# Cierra sesión y vuelve a iniciarla para que los cambios de grupo surtan efecto
```

O instala Podman como alternativa:

```bash
sudo apt update
sudo apt install podman
```

#### 2. Clonar el Repositorio

```bash
git clone https://github.com/ROCKNIX/distribution.git ROCKNIX
cd ROCKNIX
```

#### 3. Compilar la Imagen

```bash
# Compilar para Raspberry Pi 5 (esto compilará las versiones de 32 y 64 bits)
make docker-RPi5
```

El proceso de compilación:
1. Descargará el contenedor de compilación de ROCKNIX más reciente
2. Compilará todos los paquetes necesarios
3. Creará la imagen del sistema

Este proceso puede tardar varias horas (2-8 horas dependiendo de tu hardware).

#### 4. Encontrar tu Imagen

Después de que la compilación se complete, encontrarás la imagen en el directorio `release`:

```bash
ls -lh release/
# Busca archivos como: ROCKNIX-RPi5.aarch64-YYYYMMDD.img.gz
```

### Método 2: Compilación Nativa (Avanzado)

Si prefieres no usar Docker, puedes compilar directamente en tu sistema.

#### 1. Instalar Dependencias

```bash
# El sistema de compilación verificará las dependencias faltantes
# Ejecuta el comando de compilación una vez para ver qué falta:
PROJECT=RPi DEVICE=RPi5 ARCH=aarch64 ./scripts/build_distro

# Proporcionará comandos apt install para los paquetes faltantes
```

#### 2. Compilar la Distribución

Para compilación de 64 bits (recomendado para Raspberry Pi 5):

```bash
PROJECT=RPi DEVICE=RPi5 ARCH=aarch64 ./scripts/build_distro
```

Para compilación de 32 bits (opcional):

```bash
PROJECT=RPi DEVICE=RPi5 ARCH=arm ./scripts/build_distro
```

#### 3. Crear la Imagen

Después de que la compilación se complete:

```bash
PROJECT=RPi DEVICE=RPi5 ARCH=aarch64 ./scripts/image
```

## Opciones de Compilación

### Limpiar Artefactos de Compilación

Si necesitas limpiar tu compilación:

```bash
# Limpiar un paquete específico
PROJECT=RPi DEVICE=RPi5 ARCH=aarch64 ./scripts/clean <nombre-del-paquete>

# Limpiar todo
make clean

# Limpieza completa (elimina todos los artefactos de compilación)
make distclean
```

### Compilar Paquetes Específicos

Para recompilar un paquete específico:

```bash
PROJECT=RPi DEVICE=RPi5 ARCH=aarch64 ./scripts/build <nombre-del-paquete>
```

### Configuración de Compilación

Puedes crear un archivo de configuración personalizado en `~/.ROCKNIX/options` para mantener la configuración de compilación:

```bash
# Ejemplo: Establecer número de trabajos paralelos
THREADCOUNT=8

# Ejemplo: Establecer versión personalizada
CUSTOM_VERSION="mi-compilacion-personalizada"
```

## Instalación

### 1. Extraer la Imagen

```bash
gunzip release/ROCKNIX-RPi5.aarch64-*.img.gz
```

### 2. Escribir en la Tarjeta SD

**Usando Balena Etcher (Recomendado para principiantes):**
1. Descarga [Balena Etcher](https://www.balena.io/etcher/)
2. Selecciona el archivo `.img`
3. Selecciona tu tarjeta SD
4. Haz clic en "Flash"

**Usando Raspberry Pi Imager:**
1. Descarga [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
2. Elige "Usar personalizado" y selecciona tu archivo `.img.gz`
3. Selecciona tu tarjeta SD
4. Haz clic en "Escribir"

**Usando dd (Linux/macOS):**

```bash
# ADVERTENCIA: ¡Verifica el nombre del dispositivo! ¡Un dispositivo incorrecto borrará tus datos!
# Encuentra el dispositivo de tu tarjeta SD (ej., /dev/sdb, /dev/mmcblk0)
lsblk

# Escribe la imagen (reemplaza /dev/sdX con el dispositivo de tu tarjeta SD)
sudo dd if=ROCKNIX-RPi5.aarch64-*.img of=/dev/sdX bs=4M status=progress
sudo sync
```

### 3. Arrancar tu Raspberry Pi 5

1. Inserta la tarjeta SD en tu Raspberry Pi 5
2. Conecta HDMI, controlador USB y alimentación
3. Enciende el dispositivo
4. ROCKNIX arrancará y realizará la configuración inicial

## Solución de Problemas

### La Compilación Falla con Dependencias Faltantes

Ejecuta el comando de compilación nuevamente y listará los paquetes requeridos. Instálalos usando tu gestor de paquetes.

### Sin Espacio en Disco

Las compilaciones de ROCKNIX requieren un espacio en disco significativo. Asegúrate de tener al menos 100GB libres.

### La Compilación Tarda Demasiado

- Usa el método Docker para mejor rendimiento
- Aumenta `THREADCOUNT` en `~/.ROCKNIX/options`
- Usa un sistema con más núcleos de CPU y RAM

### La Imagen No Arranca

- Asegúrate de estar usando una tarjeta SD de buena calidad (Clase 10 o mejor)
- Verifica que la imagen se escribió correctamente
- Comprueba que tu Raspberry Pi 5 tiene el firmware del bootloader más reciente

## Recursos Adicionales

- [Documentación de ROCKNIX](https://rocknix.org)
- [Comunidad Discord de ROCKNIX](https://discord.gg/seTxckZjJy)
- [README del Proyecto RPi](../../../projects/RPi/README.md)
- [Guía General de Compilación](https://rocknix.org/contribute/build/)

## Referencia Rápida

```bash
# Compilación con Docker (más fácil)
make docker-RPi5

# Compilación nativa de 64 bits
PROJECT=RPi DEVICE=RPi5 ARCH=aarch64 ./scripts/build_distro

# Crear imagen
PROJECT=RPi DEVICE=RPi5 ARCH=aarch64 ./scripts/image

# Limpiar compilación
make clean
```
