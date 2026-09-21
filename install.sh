#!/usr/bin/env bash
set -e

echo "=========================================="
echo "  React App + Nix Setup"
echo "=========================================="
echo ""

# Check if Nix is installed
if command -v nix &> /dev/null; then
    echo "✓ Nix is already installed"
    nix --version
else
    echo "⚡ Installing Nix..."
    echo ""
    echo "This will:"
    echo "  1. Install Nix package manager"
    echo "  2. Enable flakes"
    echo "  3. Create /nix directory"
    echo ""
    
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    
    echo ""
    echo "✓ Nix installed!"
    source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

echo ""
echo "✓ Everything ready!"
echo ""
echo "Next: Run:"
echo "  nix develop"
echo ""
