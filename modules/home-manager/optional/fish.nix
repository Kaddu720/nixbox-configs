{
  lib,
  config,
  ...
}: {
  options = {
    fish.enable =
      lib.mkEnableOption "enables fish shell";
  };

  config = lib.mkIf config.fish.enable {
    programs = {
      fish = {
        enable = true;
        interactiveShellInit =
          /*
          fish
          */
          ''
            function fish_greeting
                echo Hail the Machine God
                echo Hail the Omnisiah
            end

            # bat color scheme
            set -gx BAT_THEME "base16"

            # Command to activate vi mode
            set -g fish_key_bindings fish_vi_key_bindings

            # Command to fix auto complete in vi mode
            bind -M insert \cf accept-autosuggestion

            # enable fzf, the fuck, and zoxide
            alias cd "z"

            # Make kubeclt less of a pain to use
            alias k "kubectl"
          '';
      };

      # extra Fish integrations
      zoxide = {
        enable = true;
        enableFishIntegration = true;
      };
      starship = {
        enable = true;
        enableFishIntegration = true;
      };
      eza = {
        enable = true;
        enableFishIntegration = true;
      };
      carapace = {
        enable = true;
        enableFishIntegration = true;
      };
      fzf.enableFishIntegration = true;
    };
  };
}
