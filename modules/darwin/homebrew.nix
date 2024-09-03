{
  lib,
  config,
  ...
}: {
  options = {
    homebrewPkgs.enable =
      lib.mkEnableOption "enables homebrew";
  };

  config = lib.mkIf config.homebrewPkgs.enable {
    # Enable home-brew (remember to go to the homebrew website and install it)
    # fish is already configured to use it
    homebrew = {
      enable = true;
      casks = [
        "amethyst"
        "gpg-suite"
        "redisinsight"
      ];
      brews = [
        "ca-certificates"
        "cffi"
        "coreutils"
        "docutils"
        "gmp"
        "jq"
        "oniguruma"
        "openssl@3"
        "pycparser"
        "python-setuptools"
        "redis"
      ];
    };

    nix-homebrew = {
      enable = true;
      enableRosetta = true;
      user = "noahwilson";
      autoMigrate = true;
    };
  };
}
