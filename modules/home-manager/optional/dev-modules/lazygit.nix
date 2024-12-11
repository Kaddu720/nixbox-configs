{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    lazygit.enable =
      lib.mkEnableOption "enables lazygit";
  };

  config = lib.mkIf config.lazygit.enable {
    home.packages = with pkgs; [lazygit];

    home.file = {
      ".config/lazygit/config.yml".text =
        /*
        yaml
        */
        ''
          os:
            editPreset: "nvim-remote"
          gui:
            theme:
               # Border color of focused window
               activeBorderColor:
                 - "#bb5c3a"
                 - bold

               # Border color of non-focused windows
               inactiveBorderColor:
                 - "#c7c4c4"

               # Border color of focused window when searching in that window
               searchingActiveBorderColor:
                 - "#563ea9"
                 - bold

               # Color of keybindings help text in the bottom line
               optionsTextColor:
                 - "#3b83aa"

               # Background color of selected line.
               # See https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md#highlighting-the-selected-line
               selectedLineBgColor:
                 - "#3b83aa"

               # Background color of selected line when view doesn't have focus.
               inactiveViewSelectedLineBgColor:
                 - bold

               # Foreground color of copied commit
               cherryPickedCommitFgColor:
                 - "#3b83aa"

               # Background color of copied commit
               cherryPickedCommitBgColor:
                 - "#563ea9"

               # Foreground color of marked base commit (for rebase)
               markedBaseCommitFgColor:
                 - "#3b83aa"

               # Background color of marked base commit (for rebase)
               markedBaseCommitBgColor:
                 - "#c78645"

               # Color for file with unstaged changes
               unstagedChangesColor:
                 - "#aa7264"

               # Default text color
               defaultFgColor:
                 - "#c7c4c4"
            nedFontsVersion: "3"
        '';
    };
  };
}
