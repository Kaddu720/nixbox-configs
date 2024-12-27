{pkgs, ...}: {
  # Import nix modules

  home = {
    username = "noahwilson";
    homeDirectory = "/Users/noahwilson";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #disables personall git credentials
  git.enable = false;

  # Use neovim from NixCats
  nvim.enable = true;

  # Install Packages
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      obsidian
      ;
    inherit
      (pkgs.nerd-fonts)
      hack
      jetbrains-mono
      ;
  };

  # Imported Optional Modules
  services.desktop-config = {
    enable = true;
    mac = {
      aerospace = true;
      skhd = true;
    };
  };

  # Standard Modules
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = [
          "~/.ssh/work-box"
        ];
      };
    };
  };
}
