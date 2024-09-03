{pkgs, ...}: {
  imports = [
    ../../modules/common/users/work/nixos.nix
    ../../modules/darwin
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system = {
    defaults = {
      dock = {
        autohide = true;
        mru-spaces = false;
      };
      finder = {
        AppleShowAllExtensions = true;
        CreateDesktop = false;
        FXPreferredViewStyle = "Nlsv";
      };

      NSGlobalDomain.AppleInterfaceStyle = "Dark";
      screensaver.askForPasswordDelay = 10;
      spaces.spans-displays = false;
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
      #swapLeftCommandAndLeftAlt = true;
    };
  };

  #Configure Environmental Variables
  environment = {
    # List packages at system level
    systemPackages = with pkgs; [
      sketchybar-app-font
      slack
      #redisinsight
    ];
  };

  #enable programs as services
  services = {
    skhd.enable = true;
    sketchybar.enable = true;
  };

  # Imported Optional Modules
  homebrew.enable = true;

  # Enable automatic garbage collection
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
