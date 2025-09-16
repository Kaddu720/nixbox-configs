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
        path = "~/Vaults"
        startup_command = "nvim ./Work_Brain"

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
    tmux.enable =
      lib.mkEnableOption "enables tmux";
  };

  config = lib.mkIf config.tmux.enable {
    home.packages = [pkgs.tmuxp pkgs.sesh];
    programs.tmux = {
      enable = true;

      shell = "${pkgs.fish}/bin/fish";
      mouse = true;
      keyMode = "vi";
      baseIndex = 1; #window and panes #s start on 1
      terminal = "ghostty";
      sensibleOnTop = false;

      plugins = with pkgs.tmuxPlugins; [
        tmux-fzf
        vim-tmux-navigator
        yank
      ];
      extraConfig = ''
        #True color settings
        set -g default-terminal "$TERM"
        set -ag terminal-overrides ",$TERM:Tc"

        #Start Windows and panes at 1, not 0
        set-option -g renumber-windows on

        #Status bar
        set -g status-interval 3
        set -g status-position top

        set -g status-justify left
        set -g status-left-length 200
        set -g status-right-length 200

        set -g status-style " "

        #Left status bar
        set -g status-left "#[fg=#eb6f92,bold,bg=#191724]  #S "
        set -g window-status-current-format '#[fg=#e0def4,bg=#191724]#I:#W'
        set -g window-status-format '#[fg=#908caa,bg=#191724]#I:#W'
        set -g window-status-separator " "

        #Right status bar
        set -g status-right "#[fg=#908caa] "" #[fg=#908caa]#{pane_current_path} "


        #Key bindings#
        # prefix key is now C-b
        unbind-key C-b
        set-option -g prefix C-a
        bind-key C-a send-prefix

        #enable true vi mode for copying
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

        #open panes in current directory
        bind v split-window -h -c "#{pane_current_path}"
        bind s split-window -v -c "#{pane_current_path}"
        unbind '"'
        unbind %

        #adjust pane size with capital 'L" or "J"
        bind -n M-H resize-pane -L 5
        bind -n M-L resize-pane -R 5
        bind -n M-K resize-pane -U 5
        bind -n M-J resize-pane -D 5

        # sesh setting
        bind-key x kill-pane # skip "kill-pane 1? (y/n)" prompt
        set -g detach-on-destroy off  # don't exit from tmux when closing a session

        # Set up Sesh last for last session behavior
        bind "L" run-shell "sesh last || tmux display-message -d 1000 'Only one session'"

        bind-key "K" run-shell "sesh connect \"$(
          sesh list -it | fzf-tmux -p 70%,80% \
            --border=none \
            --color='border:#e0def4,label:#e0def4,pointer:#f7768e' \
            --list-label ' Sessions ' --list-border=rounded --layout=reverse --no-sort --ansi --prompt '>  ' \
            --header ' :: & <ctrl-a> to add & <ctrl-x> to close' \
            --bind 'ctrl-x:execute(tmux kill-session -t {2..})+change-prompt(>  )+reload(sesh list -it)' \
            --bind 'ctrl-a:change-prompt(  )+reload(sesh list -icz)' \
            --preview-window 'right:60%:rounded' \
            --preview 'sesh preview {}'
        )\""
      '';
    };

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
