#!/usr/bin/env sh

# To change to monitor mode on qemu, ctrl+a c
curl -L https://github.com/raspberrypi/firmware/raw/refs/heads/stable/boot/bcm2711-rpi-4-b.dtb -o bcm2711.dtb
curl -L https://github.com/raspberrypi/firmware/raw/refs/heads/stable/boot/kernel8.img -o kernel8.img
qemu-img resize ./raspi_4_bookworm.img 4G

# Add -s -S if you want to debug
# !!! Use ttyAMA1 instead of ttyAMA0 – fe201000.serial sets up this device!
qemu-system-aarch64 \
    -M raspi4b \
    -m 2G \
    -cpu host,accel=vhf \
    -serial mon:stdio \
    -nographic \
    -dtb bcm2711.dtb \
    -kernel kernel8.img \
    -usb \
    -device usb-kbd \
    -device usb-net,netdev=net0 -netdev user,id=net0,hostfwd=tcp::2222-:22 \
    -append "systemd.log_level=debug systemd.log_target=console earlycon=pl011,mmio32,0xfe201000 root=/dev/mmcblk1p2 rootdelay=1 console=ttyAMA1 otg_mode=1"
