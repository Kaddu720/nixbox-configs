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
    (nerdfonts.override {fonts = ["Hack"];})
    (python311.withPackages (ppkgs: [
      ppkgs.boto3
    ]))
    obsidian
  ];
}
