{pkgs, ...}: {
  # -------------------- User Configuration --------------------
  home = {
    username = "noahwilson";
    homeDirectory = "/Users/noahwilson";
  };

  # -------------------- Package Management --------------------
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # -------------------- Git Configuration --------------------
  #disables personall git credentials
  git.enable = false;

  # -------------------- Editor Configuration --------------------
  # Use neovim from NixCats
  nvim.enable = true;

  # -------------------- User Packages --------------------
  # Install Packages
  home.packages = with pkgs; [
    obsidian
    nerd-fonts.jetbrains-mono
  ];

  # -------------------- Desktop Services --------------------
  # Imported Optional Modules
  services.desktop-config = {
    enable = true;
    macDesktop = true;
  };
}
