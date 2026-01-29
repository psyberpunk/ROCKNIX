# Raspberry Pi 5 Documentation

Welcome to the ROCKNIX documentation for Raspberry Pi 5.

## Building ROCKNIX for Raspberry Pi 5

- [Build Instructions (English)](BUILD.md) - Complete guide on how to compile ROCKNIX for Raspberry Pi 5
- [Instrucciones de Compilación (Español)](BUILD_ES.md) - Guía completa sobre cómo compilar ROCKNIX para Raspberry Pi 5

## Quick Start

### Using Docker (Easiest)

```bash
git clone https://github.com/ROCKNIX/distribution.git ROCKNIX
cd ROCKNIX
make docker-RPi5
```

### Native Build

```bash
PROJECT=RPi DEVICE=RPi5 ARCH=aarch64 ./scripts/build_distro
PROJECT=RPi DEVICE=RPi5 ARCH=aarch64 ./scripts/image
```

## Device Information

**Supported Models:**
- Raspberry Pi 5

**Architecture:**
- 64-bit ARM (aarch64) - Recommended
- 32-bit ARM (arm) - Also supported

**Key Features:**
- Cortex-A76 CPU
- VideoCore VII GPU
- Full hardware acceleration support
- HDMI output
- USB controller support
- Bluetooth audio support

## Installation

After building or downloading a ROCKNIX image:

1. Extract the `.img.gz` file
2. Write to a microSD card using [Balena Etcher](https://www.balena.io/etcher/) or [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
3. Insert the SD card into your Raspberry Pi 5
4. Boot the device

## Additional Resources

- [Main README](../../../README.md)
- [RPi Project Documentation](../../../projects/RPi/README.md)
- [ROCKNIX Website](https://rocknix.org)
- [Discord Community](https://discord.gg/seTxckZjJy)
