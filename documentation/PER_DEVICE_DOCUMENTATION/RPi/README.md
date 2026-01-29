# Raspberry Pi 1 / Zero Documentation

## Building ROCKNIX for Raspberry Pi 1 / Zero

For detailed build instructions, see the [RPi Project README](../../../projects/RPi/README.md).

### Quick Build

Using Docker (recommended):
```bash
make docker-RPi
```

Native build:
```bash
# 32-bit only (RPi1/Zero requires 32-bit)
PROJECT=RPi DEVICE=RPi ARCH=arm ./scripts/build_distro
PROJECT=RPi DEVICE=RPi ARCH=arm ./scripts/image
```

## Supported Devices

- Raspberry Pi Model B
- Raspberry Pi Model B+
- Raspberry Pi Zero
- Raspberry Pi Zero W

## Installation

1. Download or build the ROCKNIX image for RPi
2. Write to a microSD card using [Balena Etcher](https://www.balena.io/etcher/) or [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
3. Insert into your Raspberry Pi and boot

## Resources

- [RPi Build Guide](../../../projects/RPi/README.md)
- [ROCKNIX Website](https://rocknix.org)
- [Build Documentation](https://rocknix.org/contribute/build/)
