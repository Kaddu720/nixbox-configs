{pkgs, ...}: {
  # Import nix modules
  imports = [
    ../../static/stylix.nix
  ];

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
  home.packages = with pkgs; [
    obsidian
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
  ];

  # Imported Optional Modules
  services.desktop-config = {
    enable = true;
    macDesktop = true;
  };
}
