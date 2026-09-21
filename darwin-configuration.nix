{ config, pkgs, lib, ... }:

{
  system.stateVersion = 5;
  system.primaryUser = "steven";  # Your actual username

  nix.settings.experimental-features = "nix-command flakes";

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

  system.defaults = {
    dock = {
      autohide = true;
      orientation = "bottom";
      show-recents = false;
    };

    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      ShowStatusBar = true;
    };

    NSGlobalDomain = {
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      AppleShowScrollBars = "Always";
    };
  };

  homebrew = {
    enable = true;
    brewPrefix = "/opt/homebrew";

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