#!/usr/bin/env bash

set -e

DOTNIX="$HOME/dotnix"
cd "$DOTNIX"

# === Backup helper ===
backup() {
    [ -e "$1" ] && mv "$1" "$1.bak.$(date +%s)" && echo "📦 Backed up $1"
}

echo "🔧 Setting up dotnix for GNU Stow..."

# === Create Stow-compatible structure ===
mkdir -p hypr/.config/hypr
mkdir -p kitty/.config/kitty
mkdir -p starship/.config
mkdir -p zsh/.config
mkdir -p nixos/etc/nixos

# === Move files to new structure ===
mv -v hypr/*.conf hypr/.config/hypr/
mv -v kitty/kitty.conf kitty/.config/kitty.conf
mv -v starship starship/.config/starship.toml
mv -v zshrc zsh/.config/.zshrc
mv -v nixos/configuration.nix nixos/etc/nixos/
mv -v nixos/hardware-configuration.nix nixos/etc/nixos/

# === Backup existing config ===
echo "🛡 Backing up existing system/user configs if needed..."
backup ~/.config/hypr
backup ~/.config/kitty
backup ~/.config/starship.toml
backup ~/.zshrc
sudo bash -c 'backup /etc/nixos'

# === Apply stow ===
echo "🔗 Creating symlinks..."
stow hypr kitty starship zsh
sudo stow -t / nixos

echo "✅ Done. Configs are now managed by GNU Stow."
