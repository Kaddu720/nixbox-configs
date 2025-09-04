{pkgs, ...}: {
  users.users.noahwilson = {
    home = "/Users/noahwilson";
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  environment.variables = {
    EDITOR = "nvim";
    HOME = "/Users/noahwilson";
    Host = "aarch65-darwin";
    AWS_PROFILE = "sre_v1-prod";
    TF_SECRET = "terraform_builder";
    NH_DARWIN_FLAKE = "/Users/noahwilson/.config/nixos#darwinConfigurations.Work-Box";
    NH_HOME_FLAKE = "/Users/noahwilson/.config/nixos#homeConfigurations.noah@Work-Box";
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
    systemPackages = with pkgs; [
      slack
    ];
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
      "redisinsight"
      "zen-browser"
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
