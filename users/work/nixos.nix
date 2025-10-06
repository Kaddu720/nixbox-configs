{pkgs, ...}: {
  users.users.noahwilson = {
    home = "/Users/noahwilson";
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  environment.variables = {
    Host = "aarch65-darwin";
  };

  system = {
    primaryUser = "noahwilson";
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
    systemPackages = with pkgs; [];
  };

  #enable programs and services
  services = {
  };

  # Homebrew
  # Enable home-brew (remember to go to the homebrew website and install it)
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "noahwilson";
    autoMigrate = true;
  };

  homebrew = {
    enable = true;
    casks = [
      "lm-studio"
      "nikitabobko/tap/aerospace"
      "hiddenbar"
      "ghostty"
      "gpg-suite"
      "raycast"
      "redis-insight"
      "zen"
    ];
    brews = [
      "ca-certificates"
      "cffi"
      "coreutils"
      "docutils"
      "gmp"
      "oniguruma"
      "openssl@3"
      "pycparser"
      "python-setuptools"
      "redis"
    ];
  };

  system.activationScripts.startUp.text = ''
    brew update
    brew upgrade
  '';
}
