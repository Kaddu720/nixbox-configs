{
  pkgs,
  lib,
  config,
  vars,
  ...
}: let
  seshConfigs =
    if "${vars.hostName}" == "Work-Box"
    then
      /*
      toml
      */
      ''
        [[session]]
        name = "Work_Brain"
        path = "~/Vaults/Work_Brain/"
        startup_command = "nvim ."

        [[session]]
        name = "axs-configurations"
        path = "~/Documents/sre_lambda_layer/GitHub/axs-configurations"
        startup_command = "tmuxp load -a lazygit ; nvim"
      ''
    else
      /*
      toml
      */
      ''
        [[session]]
        name = "Second_Brain"
        path = "~/Vaults/Second_Brain"
        startup_command = "nvim ."

        [[session]]
        name = "ekiree_dashboard"
        path = "~/Projects/dashboard/dev/ekiree_dashboard"
        startup_command = "tmuxp load -a ekiree_dashboard ; tmux split-window -h -l 30% ; nvim"
      '';
in {
  options = {
    sesh.enable =
      lib.mkEnableOption "enables sesh";
  };

  config = lib.mkIf config.sesh.enable {
    home.packages = [pkgs.tmuxp pkgs.sesh];

    ## Sesh configs
    home.file = {
      ".config/sesh/sesh.toml".text =
        /*
        toml
        */
        ''
          ${seshConfigs}

          [default_session]
          startup_command = "tmuxp load -a lazygit && tmux split-window -h -l 30% && nvim"
          # startup_command = "tmuxp load -a lazygit ; tmux split-window -h -l 30% ; nvim"


          [[session]]
          name = "nixos"
          path = "~/.nixos"
          startup_command = "tmuxp load -a lazygit && tmux split-window -h -l 30% && nvim"
          # startup_command = "tmuxp load -a lazygit ; tmux split-window -h -l 30% ; nvim"

          [[session]]
          name = "nvim-dev"
          path = "~/.config/nvim"
          startup_command = "tmuxp load -a lazygit && nvim"
          # startup_command = "tmuxp load -a lazygit ; nvim"

        '';
    };

    ## tmuxp config
    home.file = {
      ".config/tmuxp/ekiree_dashboard.yaml".text =
        /*
        yaml
        */
        ''
          session_name: ekiree_dashboard

          windows:
          - window_name: term
            layout: main-vertical
            shell_command_before:
              - cd ekiree_dashboard
            panes:
              - shell_command:
                - clear
                focus: true
              - shell_command:
                - clear
                - python manage.py runserver

          - window_name: git
            panes:
              - shell_command:
                - lazygit
        '';

      ".config/tmuxp/lazygit.yaml".text =
        /*
        yaml
        */
        ''
          session_name: lazygit

          windows:
          - window_name: git
            panes:
              - shell_command:
                - lazygit
        '';
    };
  };
}
