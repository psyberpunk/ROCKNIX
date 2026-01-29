# Raspberry Pi 2 Documentation

## Building ROCKNIX for Raspberry Pi 2

For detailed build instructions, see the [RPi Project README](../../../projects/RPi/README.md).

### Quick Build

Using Docker (recommended):
```bash
make docker-RPi2
```

Native build:
```bash
# 32-bit only (RPi2 requires 32-bit)
PROJECT=RPi DEVICE=RPi2 ARCH=arm ./scripts/build_distro
PROJECT=RPi DEVICE=RPi2 ARCH=arm ./scripts/image
```

## Supported Devices

- Raspberry Pi 2 Model B

## Installation

1. Download or build the ROCKNIX image for RPi2
2. Write to a microSD card using [Balena Etcher](https://www.balena.io/etcher/) or [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
3. Insert into your Raspberry Pi 2 and boot

## Resources

- [RPi Build Guide](../../../projects/RPi/README.md)
- [ROCKNIX Website](https://rocknix.org)
- [Build Documentation](https://rocknix.org/contribute/build/)
