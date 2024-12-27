{pkgs, ...}: {
  users.users.noahwilson = {
    home = "/Users/noahwilson";
  };

  security.pam.enableSudoTouchIdAuth = true;

  environment.variables = {
    EDITOR = "nvim";
    HOME = "/Users/noahwilson";
    Host = "aarch65-darwin";
    AWS_PROFILE = "sre_v1-prod";
    TF_SECRET = "terraform_builder";
  };

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
    systemPackages = [
      pkgs.slack
    ];
  };

  #enable programs and services
  services = {
    skhd.enable = true;
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
      "nikitabobko/tap/aerospace"
      "hiddenbar"
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
}
