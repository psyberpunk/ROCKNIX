# Raspberry Pi

This project provides ROCKNIX support for Raspberry Pi devices.

## Supported Devices

**RPi (Raspberry Pi 1)**
* Raspberry Pi Model B
* Raspberry Pi Model B+
* Raspberry Pi Zero
* Raspberry Pi Zero W

**RPi2 (Raspberry Pi 2)**
* Raspberry Pi 2 Model B

**RPi4 (Raspberry Pi 4)**
* Raspberry Pi 4 Model B
* Raspberry Pi 400
* Raspberry Pi Compute Module 4

**RPi5 (Raspberry Pi 5)**
* Raspberry Pi 5

## Building ROCKNIX for Raspberry Pi

### Prerequisites

You'll need a Linux build environment with the necessary dependencies installed. See the [Building ROCKNIX](https://rocknix.org/contribute/build/) guide for detailed prerequisites.

### Building with Docker (Recommended)

The easiest way to build ROCKNIX is using Docker:

```bash
# For Raspberry Pi 5 (builds both 32-bit and 64-bit)
make docker-RPi5

# For Raspberry Pi 4 (builds both 32-bit and 64-bit)
make docker-RPi4

# For Raspberry Pi 2 (32-bit only)
make docker-RPi2

# For Raspberry Pi 1/Zero (32-bit only)
make docker-RPi
```

### Building Natively

If you prefer to build without Docker, you need to export the required environment variables and run the build script:

```bash
# For Raspberry Pi 5 (64-bit ARM)
PROJECT=RPi DEVICE=RPi5 ARCH=aarch64 ./scripts/build_distro

# For Raspberry Pi 5 (32-bit ARM - optional)
PROJECT=RPi DEVICE=RPi5 ARCH=arm ./scripts/build_distro

# For Raspberry Pi 4 (64-bit ARM)
PROJECT=RPi DEVICE=RPi4 ARCH=aarch64 ./scripts/build_distro

# For Raspberry Pi 2
PROJECT=RPi DEVICE=RPi2 ARCH=arm ./scripts/build_distro

# For Raspberry Pi 1/Zero
PROJECT=RPi DEVICE=RPi ARCH=arm ./scripts/build_distro
```

### Build Output

After a successful build, you'll find the image in the `release` directory:

```
release/ROCKNIX-RPi5.aarch64-<date>.img.gz
```

### Creating the Image

To create the final image file:

```bash
PROJECT=RPi DEVICE=RPi5 ARCH=aarch64 ./scripts/image
```

## Installation

1. Download or build your Raspberry Pi image
2. Decompress the image file (if compressed)
3. Write the image to a microSD card using:
   - [Balena Etcher](https://www.balena.io/etcher/)
   - [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
   - Or `dd` command on Linux/macOS
4. Insert the microSD card into your Raspberry Pi
5. Power on the device

## Notes

- Raspberry Pi 5 is recommended to use 64-bit build (ARCH=aarch64) but also supports 32-bit
- Raspberry Pi 4 works best with the 64-bit build but also supports 32-bit
- Raspberry Pi 2 requires a 32-bit build (ARCH=arm)
- Raspberry Pi 1/Zero requires a 32-bit build (ARCH=arm)
- Build times can be very long (several hours) depending on your system

## Links

* [Official Raspberry Pi Documentation](https://www.raspberrypi.com/documentation/)
* [ROCKNIX Website](https://rocknix.org)
* [Building ROCKNIX Guide](https://rocknix.org/contribute/build/)
