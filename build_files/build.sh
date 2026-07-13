#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install Sway and a minimal Wayland desktop stack on top of Bazzite.
# Bazzite ships with KDE (or GNOME); we add Sway as an additional session
# selectable from the display manager (SDDM).
dnf5 install -y \
    sway \
    swaybg \
    swayidle \
    swaylock \
    waybar \
    foot \
    wofi \
    mako \
    grim \
    slurp \
    wl-clipboard \
    brightnessctl \
    playerctl \
    polkit-gnome \
    xdg-desktop-portal-wlr \
    NetworkManager-tui

# Make sure the Sway wayland session is discoverable by display managers.
# The sway package already installs /usr/share/wayland-sessions/sway.desktop,
# but we enable a couple of user-facing services here.

systemctl enable podman.socket
