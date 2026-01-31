# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bcm2835-bootloader"
PKG_VERSION="8afbe608658d2ad0093df191afb6135d6a8326bc"
PKG_SHA256="acde6ead1bf7173ac118318c54c4845b5e70b3016710e8b0365023ff49c76ab9"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="https://github.com/raspberrypi/firmware"
PKG_URL="https://github.com/raspberrypi/firmware.git"
PKG_DEPENDS_TARGET="toolchain linux bcmstat"
PKG_LONGDESC="bcm2835-bootloader: Tool to create a bootable kernel for RaspberryPi"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/bootloader
    cp -PRv boot/LICENCE* ${INSTALL}/usr/share/bootloader
    case "${DEVICE}" in
      RPi4)
        cp -PRv boot/fixup4x.dat ${INSTALL}/usr/share/bootloader/fixup.dat
        cp -PRv boot/start4x.elf ${INSTALL}/usr/share/bootloader/start.elf
        ;;
      RPi5) ;;
      *)
        cp -PRv boot/bootcode.bin ${INSTALL}/usr/share/bootloader
        cp -PRv boot/fixup_x.dat ${INSTALL}/usr/share/bootloader/fixup.dat
        cp -PRv boot/start_x.elf ${INSTALL}/usr/share/bootloader/start.elf
        ;;
    esac

    find_file_path bootloader/update.sh ${PKG_DIR}/files/update.sh && cp -PRv ${FOUND_PATH} ${INSTALL}/usr/share/bootloader

    if find_file_path bootloader/canupdate.sh; then
      cp -PRv ${FOUND_PATH} ${INSTALL}/usr/share/bootloader
      sed -e "s/@PROJECT@/${DEVICE:-${PROJECT}}/g" \
          -i ${INSTALL}/usr/share/bootloader/canupdate.sh
    fi

    find_file_path config/distroconfig.txt ${PKG_DIR}/files/distroconfig.txt && cp -PRv ${FOUND_PATH} ${INSTALL}/usr/share/bootloader
    find_file_path config/distroconfig-composite.txt ${PKG_DIR}/files/distroconfig-composite.txt && cp -PRv ${FOUND_PATH} ${INSTALL}/usr/share/bootloader
    find_file_path config/config.txt ${PKG_DIR}/files/config.txt && cp -PRv ${FOUND_PATH} ${INSTALL}/usr/share/bootloader
}
