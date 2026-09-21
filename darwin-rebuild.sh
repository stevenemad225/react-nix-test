#!/usr/bin/env bash
set -e

echo "=========================================="
echo "  macOS System Rebuild with nix-darwin"
echo "=========================================="
echo ""

if ! command -v nix &> /dev/null; then
    echo "❌ Nix not found. Run install.sh first"
    exit 1
fi

echo "System: $(uname -m)"
echo ""

if ! command -v darwin-rebuild &> /dev/null; then
    echo "📦 Installing nix-darwin first time..."
    nix run nix-darwin#default -- switch --flake ".#my-machine"
else
    echo "🔧 Applying system configuration..."
    darwin-rebuild switch --flake ".#my-machine"
fi

echo ""
echo "✅ Done!"
