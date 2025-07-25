{
  lib,
  config,
  ...
}: {
  options = {
    nushell.enable =
      lib.mkEnableOption "enables nushell shell";
  };

  config = lib.mkIf config.nushell.enable {
    programs = {
      nushell = {
        enable = true;
        configFile.text =
          /*
          nu
          */
          ''
            # set up welcome banner
            def welcome [] {
              print $"Hail the Machine God"
              print $"Hail the Omnisiah"
            }
            welcome

            $env.config = {
              # disable default banner
              show_banner: false
              buffer_editor: nvim
              edit_mode: vi
              keybindings: [
                {
                    name: accept_autosuggestion
                    modifier: control
                    keycode: char_f
                    mode: vi_insert
                    event: { send: historyhintcomplete }
                }
              ]
            }
          '';

        shellAliases = {
          # Zoxide
          cd = "z";
          # Kubectl
          k = "kubectl";
          # ripgrep
          grep = "rg";
          #bat
          cat = "bat";
        };
      };

      # Extra nushell integrations
      zoxide = {
        enable = true;
        enableNushellIntegration = true;
      };
      starship = {
        enable = true;
        enableNushellIntegration = true;
      };
      eza = {
        enable = true;
        enableNushellIntegration = true;
      };
      carapace = {
        enable = true;
        enableNushellIntegration = true;
      };
      atuin = {
        enable = true;
        enableNushellIntegration = true;
      };
      direnv.enableNushellIntegration = true;
    };
  };
}
