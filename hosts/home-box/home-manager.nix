{...}: {
  imports = [
    ../../modules/common/users/noah/home.nix
  ];

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = [
          "~/.ssh/personal/personal"
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
