{...}: {
  imports = [
    ../../modules/common/users/noah/home.nix
    ../../modules/home-manager/core
    ../../modules/home-manager/optional/desktop
    ../../modules/home-manager/optional/linux-desktop
    ../../modules/home-manager/optional/dev-modules
  ];

  # Standard Modules
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = [
          "~/.ssh/mobile/mobile"
        ];
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Origial nix version this was configured on
  # Dont' delete or it could bork the entire config
  home.stateVersion = "23.11";
}
