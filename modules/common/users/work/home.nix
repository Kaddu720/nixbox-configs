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

  # Install Packages
  home.packages = with pkgs; [
    #(nerdfonts.override {fonts = ["Hack"];})
    nerd-fonts.hack
    obsidian
  ];

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
