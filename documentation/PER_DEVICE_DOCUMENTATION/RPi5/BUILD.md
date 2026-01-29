# Building ROCKNIX for Raspberry Pi 5

This guide explains how to compile a ROCKNIX image for the Raspberry Pi 5.

## Prerequisites

### System Requirements

- A Linux-based system (Ubuntu 20.04 or newer recommended)
- At least 100GB of free disk space
- At least 16GB of RAM (32GB recommended for faster builds)
- Multiple CPU cores (builds are parallelized)
- Stable internet connection

### Required Dependencies

On Ubuntu/Debian systems, you'll need to install several build dependencies. The build system will check for missing dependencies and provide installation instructions.

Common dependencies include:
- gcc, g++, make
- git
- xsltproc, xmlstarlet
- gperf
- Various font and image processing tools

## Building Methods

### Method 1: Using Docker (Recommended)

Docker is the easiest and most reliable way to build ROCKNIX, as it provides a consistent build environment.

#### 1. Install Docker

```bash
# For Ubuntu/Debian
sudo apt update
sudo apt install docker.io
sudo usermod -aG docker $USER
# Log out and log back in for group changes to take effect
```

Or install Podman as an alternative:

```bash
sudo apt update
sudo apt install podman
```

#### 2. Clone the Repository

```bash
git clone https://github.com/ROCKNIX/distribution.git ROCKNIX
cd ROCKNIX
```

#### 3. Build the Image

```bash
# Build for Raspberry Pi 5 (this will build both 32-bit and 64-bit versions)
make docker-RPi5
```

The build process will:
1. Pull the latest ROCKNIX build container
2. Compile all necessary packages
3. Create the system images (both 32-bit and 64-bit)

This process can take several hours (2-8 hours depending on your hardware).

#### 4. Find Your Image

After the build completes, you'll find the images in the `release` directory:

```bash
ls -lh release/
# Look for files like: 
# ROCKNIX-RPi5.aarch64-YYYYMMDD.img.gz (64-bit, recommended)
# ROCKNIX-RPi5.arm-YYYYMMDD.img.gz (32-bit)
```

### Method 2: Native Build (Advanced)

If you prefer not to use Docker, you can build directly on your system.

#### 1. Install Dependencies

```bash
# The build system will check for missing dependencies
# Run the build command once to see what's missing:
PROJECT=RPi DEVICE=RPi5 ARCH=aarch64 ./scripts/build_distro

# It will provide apt install commands for missing packages
```

#### 2. Build the Distribution

For 64-bit build (recommended for Raspberry Pi 5):

```bash
PROJECT=RPi DEVICE=RPi5 ARCH=aarch64 ./scripts/build_distro
```

For 32-bit build (optional):

```bash
PROJECT=RPi DEVICE=RPi5 ARCH=arm ./scripts/build_distro
```

#### 3. Create the Image

After the build completes:

```bash
PROJECT=RPi DEVICE=RPi5 ARCH=aarch64 ./scripts/image
```

## Build Options

### Cleaning Build Artifacts

If you need to clean your build:

```bash
# Clean a specific package
PROJECT=RPi DEVICE=RPi5 ARCH=aarch64 ./scripts/clean <package-name>

# Clean everything
make clean

# Complete clean (removes all build artifacts)
make distclean
```

### Building Specific Packages

To rebuild a specific package:

```bash
PROJECT=RPi DEVICE=RPi5 ARCH=aarch64 ./scripts/build <package-name>
```

### Build Configuration

You can create a custom configuration file at `~/.ROCKNIX/options` to persist build settings:

```bash
# Example: Set number of parallel jobs
THREADCOUNT=8

# Example: Set custom version
CUSTOM_VERSION="my-custom-build"
```

## Installation

### 1. Extract the Image (Optional)

**Note:** Balena Etcher and Raspberry Pi Imager can work with compressed `.img.gz` files directly. You only need to extract the image if using the `dd` command.

```bash
gunzip release/ROCKNIX-RPi5.aarch64-*.img.gz
```

### 2. Write to SD Card

**Using Balena Etcher (Recommended for beginners):**
1. Download [Balena Etcher](https://www.balena.io/etcher/)
2. Select the `.img` file
3. Select your SD card
4. Click "Flash"

**Using Raspberry Pi Imager:**
1. Download [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
2. Choose "Use custom" and select your `.img.gz` file
3. Select your SD card
4. Click "Write"

**Using dd (Linux/macOS):**

```bash
# WARNING: Double-check the device name! Wrong device will erase your data!
# Find your SD card device (e.g., /dev/sdb, /dev/mmcblk0)
lsblk

# Write the image (replace /dev/sdX with your SD card device)
sudo dd if=ROCKNIX-RPi5.aarch64-*.img of=/dev/sdX bs=4M status=progress
sudo sync
```

### 3. Boot Your Raspberry Pi 5

1. Insert the SD card into your Raspberry Pi 5
2. Connect HDMI, USB controller, and power
3. Power on the device
4. ROCKNIX will boot and perform initial setup

## Troubleshooting

### Build Fails with Missing Dependencies

Run the build command again and it will list the required packages. Install them using your package manager.

### Out of Disk Space

ROCKNIX builds require significant disk space. Ensure you have at least 100GB free.

### Build Takes Too Long

- Use Docker method for better performance
- Increase `THREADCOUNT` in `~/.ROCKNIX/options`
- Use a system with more CPU cores and RAM

### Image Doesn't Boot

- Ensure you're using a good quality SD card (Class 10 or better)
- Verify the image was written correctly
- Check that your Raspberry Pi 5 has the latest bootloader firmware

## Additional Resources

- [ROCKNIX Documentation](https://rocknix.org)
- [ROCKNIX Discord Community](https://discord.gg/seTxckZjJy)
- [RPi Project README](../../../projects/RPi/README.md)
- [General Build Guide](https://rocknix.org/contribute/build/)

## Quick Reference

```bash
# Docker build (easiest)
make docker-RPi5

# Native 64-bit build
PROJECT=RPi DEVICE=RPi5 ARCH=aarch64 ./scripts/build_distro

# Create image
PROJECT=RPi DEVICE=RPi5 ARCH=aarch64 ./scripts/image

# Clean build
make clean
```
