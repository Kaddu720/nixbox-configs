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
        envFile.text = ''
          #enable zoxide
          zoxide init nushell | save -f ~/.zoxide.nu
        '';
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

            #enable zoxide
            source ~/.zoxide.nu
            alias cd = z

            #config eza
            alias e = eza

            # Make kubeclt less of a pain to use
            alias k = kubectl
          '';
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
        enableNushellIntegration = false;
      };
      carapace = {
        enable = true;
        enableNushellIntegration = true;
      };
      atuin = {
        enable = true;
      };
      direnv.enableNushellIntegration = true;
    };
  };
}
