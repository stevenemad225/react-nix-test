cat > flake-system.nix << 'EOF'
{
  description = "macOS system with nix-darwin + React app";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nix-darwin, flake-utils }:
    {
      darwinConfigurations."my-machine" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";  # Apple Silicon; use "x86_64-darwin" for Intel
        modules = [
          ./darwin-configuration.nix
        ];
      };
    };
}
EOF