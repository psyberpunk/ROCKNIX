# Raspberry Pi 4 Documentation

## Building ROCKNIX for Raspberry Pi 4

For detailed build instructions, see the [RPi Project README](../../../projects/RPi/README.md).

### Quick Build

Using Docker (recommended):
```bash
make docker-RPi4
```

Native build:
```bash
# 64-bit (recommended)
PROJECT=RPi DEVICE=RPi4 ARCH=aarch64 ./scripts/build_distro
PROJECT=RPi DEVICE=RPi4 ARCH=aarch64 ./scripts/image

# 32-bit
PROJECT=RPi DEVICE=RPi4 ARCH=arm ./scripts/build_distro
PROJECT=RPi DEVICE=RPi4 ARCH=arm ./scripts/image
```

## Supported Devices

- Raspberry Pi 4 Model B (all RAM variants)
- Raspberry Pi 400
- Raspberry Pi Compute Module 4

## Installation

1. Download or build the ROCKNIX image for RPi4
2. Write to a microSD card using [Balena Etcher](https://www.balena.io/etcher/) or [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
3. Insert into your Raspberry Pi 4 and boot

## Resources

- [RPi Build Guide](../../../projects/RPi/README.md)
- [ROCKNIX Website](https://rocknix.org)
- [Build Documentation](https://rocknix.org/contribute/build/)
