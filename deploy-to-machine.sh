#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    echo "Usage: ./deploy-to-machine.sh user@hostname.local"
    echo "Example: ./deploy-to-machine.sh admin@other-mac.local"
    exit 1
fi

REMOTE=$1
PROJECT_NAME="react-nix-app"
REMOTE_PATH="/tmp/$PROJECT_NAME"

echo "🚀 Deploying to $REMOTE"
echo ""

# Copy files
echo "📦 Copying project..."
ssh "$REMOTE" "mkdir -p $REMOTE_PATH"
rsync -avz \
    --exclude=.git \
    --exclude=node_modules \
    --exclude=dist \
    --exclude=result \
    . "$REMOTE:$REMOTE_PATH/"

echo "✓ Files copied"
echo ""

# Install Nix
echo "⚡ Installing Nix on remote machine..."
ssh "$REMOTE" "cd $REMOTE_PATH && bash install.sh"

echo ""
echo "✓ Next steps on the remote machine:"
echo "   1. ssh $REMOTE"
echo "   2. cd $REMOTE_PATH"
echo "   3. nix build"
echo "   4. Copy the 'got:' hash into flake.nix"
echo "   5. nix build"
echo "   6. bash darwin-rebuild.sh"
