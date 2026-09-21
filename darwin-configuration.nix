cat > darwin-configuration.nix << 'EOF'
{ config, pkgs, lib, ... }:

{
  # System version (required)
  system.stateVersion = 5;

  # Your macOS username — CHANGE THIS to your actual username
  # Run: whoami
  # to see your username
  system.primaryUser = "user";

  # Enable Nix flakes
  nix.settings.experimental-features = "nix-command flakes";

  # Packages available to all users
  environment.systemPackages = with pkgs; [
    git
    ripgrep
    fzf
    curl
    wget
    htop
    vim
    nodejs_22
  ];

  # macOS defaults
  system.defaults = {
    # Dock settings
    dock = {
      autohide = true;
      orientation = "bottom";
      show-recents = false;
    };

    # Finder settings
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      ShowStatusBar = true;
    };

    # Global keyboard/system settings
    NSGlobalDomain = {
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      AppleShowScrollBars = "Always";
    };
  };

  # Homebrew for GUI apps
  homebrew = {
    enable = true;
    brewPrefix = "/opt/homebrew";  # Apple Silicon; use /usr/local for Intel

    casks = [
      "visual-studio-code"
      "firefox"
    ];

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
  };
}
EOF