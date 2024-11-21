#!/usr/bin/env sh

echo "Cleanup"
sudo umount /mnt/raspbian/boot/firmware
sudo umount /mnt/raspbian
sudo losetup -D
sudo rm -rf /mnt/raspbian

set -e

echo "Setup"
sudo losetup -P /dev/loop0 raspi_4_bookworm.img
sudo mkdir /mnt/raspbian
sudo mount /dev/loop0p2 /mnt/raspbian
sudo mount /dev/loop0p1 /mnt/raspbian/boot/firmware

set +e

echo "tests"
cat /mnt/raspbian/boot/cmdline.txt | grep cloud-config-url \
    || ( echo "no cloud-config-url on cmdline"
         cat /mnt/raspbian/boot/cmdline.txt )
sudo chroot /mnt/raspbian apt list --installed | grep cloud-init \
    || (echo "no cloud-init installed")
sudo chroot /mnt/raspbian apt list --installed | grep libnss-mdns \
    || (echo "no libnss-mdns installed")
sudo chroot /mnt/raspbian apt list --installed | grep openssh-server \
    || (echo "no openssh-server installed")
sudo chroot /mnt/raspbian apt list --installed | grep systemd-resolved \
    || (echo "no systemd-resolved installed")
sudo chroot /mnt/raspbian apt list --installed | grep raspi-firmware | grep 20240924 \
    || (echo "raspi-firmware wrong!";)

echo "Cleanup"
sudo umount /mnt/raspbian/boot/firmware
sudo umount /mnt/raspbian
sudo losetup -D
sudo rm -rf /mnt/raspbian
