#!/bin/bash
password=$(kdialog --password "Enter your sudo password")
if [ -z "$password" ]; then
    kdialog --error "No password entered. Exiting."
    exit 1
fi

# Pass the password to sudo -v
echo "$password" | sudo -Sv
dnf install fedpkg fedora-packager rpmdevtools rpmlint ncurses-devel pesign grubby qt5-qtbase-devel libXi-devel gcc-c++\
 bpftool dwarves elfutils-devel gcc-plugin-devel glibc-static kernel-rpm-macros perl-devel perl-generators python3-devel systemd-boot-unsigned
mkdir /tmp/nerokernel
cd /tmp/nerokernel
wget https://github.com/NeroReflex/linux/archive/refs/tags/v6.1.73-neroreflex-neptune.tar.gz
tar xf v6.1.73-neroreflex-neptune.tar.gz
cd linux-6.1.73-neroreflex-neptune
wget https://raw.githubusercontent.com/damian5466/ally-nobara-valve-kernel/main/.config
make bzImage -j16 && make modules -j16
make modules_install -j16
make install
