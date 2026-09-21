# Create flake.nix in your project root
cat > flake.nix << 'EOF'
{
  description = "React (Vite) app with Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        # Dev shell: nix develop
        devShells.default = pkgs.mkShell {
          packages = [ pkgs.nodejs_22 ];
          shellHook = ''
            echo "🚀 React Nix dev shell"
            echo "node $(node --version) / npm $(npm --version)"
          '';
        };

        # Production build: nix build
        packages.default = pkgs.buildNpmPackage {
          pname = "react-nix-app";
          version = "0.0.0";
          src = ./.;

          # Replace this with the real hash after first build attempt
          npmDepsHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";

          buildPhase = ''
            npm run build
          '';

          installPhase = ''
            mkdir -p $out
            cp -r dist/* $out/
          '';
        };
      }
    );
}
EOF