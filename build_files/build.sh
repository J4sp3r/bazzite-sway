#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install Sway and a Wayland desktop stack on top of Bazzite.
# Bazzite ships with KDE; we add Sway as an additional session selectable
# from the display manager (SDDM).
dnf5 install -y \
    sway \
    sway-config-fedora \
    sway-systemd \
    swaybg \
    swayidle \
    swaylock \
    waybar \
    foot \
    wofi \
    rofi-wayland \
    wlogout \
    mako \
    grim \
    slurp \
    brightnessctl \
    playerctl \
    xdg-desktop-portal-wlr \
    NetworkManager-tui

### Identify this image as bazzite-sway to ublue tooling and os-release.
IMAGE_INFO="/usr/share/ublue-os/image-info.json"
if [[ -f "$IMAGE_INFO" ]]; then
    sed -i \
        -e 's|"image-name"[[:space:]]*:[[:space:]]*"[^"]*"|"image-name": "bazzite-sway"|' \
        -e 's|"image-ref"[[:space:]]*:[[:space:]]*"[^"]*"|"image-ref": "ostree-image-signed:docker://ghcr.io/j4sp3r/bazzite-sway"|' \
        "$IMAGE_INFO"
fi
sed -i 's/^VARIANT_ID=.*/VARIANT_ID=bazzite-sway/' /usr/lib/os-release

systemctl enable podman.socket
