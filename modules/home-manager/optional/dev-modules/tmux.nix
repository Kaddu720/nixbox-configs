{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    tmux.enable =
      lib.mkEnableOption "enables tmux";
  };

  config = lib.mkIf config.tmux.enable {
    home.packages = with pkgs; [tmuxp];

    programs.tmux = {
      enable = true;

      shell = "${pkgs.fish}/bin/fish";
      mouse = true;
      keyMode = "vi";
      baseIndex = 1; #window and panes #s start on 1
      terminal = "alacritty";
      sensibleOnTop = false;

      plugins = with pkgs.tmuxPlugins; [
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
        set -g status-left "#[fg=#26233a,bold,bg=#ebbcba] #S #[fg=#ebbcba,bg=#191724] "
        set -g window-status-current-format '#[fg=#ebbcba]#I:#W'
        set -g window-status-format '#[fg=#908caa]#I:#W'
        set -g window-status-separator " "

        #Right status bar
        set -g status-right "#[fg=#908caa] "" #[fg=#908caa]#{pane_current_path} "


        #Key bindings#
        # prefix key is now C-b
        unbind-key C-b
        set-option -g prefix C-a
        bind-key C-a send-prefix

        # navigate panes with vim keyes
        bind-key h select-pane -L
        bind-key j select-pane -D
        bind-key k select-pane -U
        bind-key l select-pane -R

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
      '';
    };

    home.file = {
      ".config/tmuxp/dashboard.yaml".text =
        /*
        yaml
        */
        ''
          session_name: Dashboard
          start_directory: ~/Projects/dashboard/dev/ekiree_dashboard

          windows:
          - window_name: notes
            panes:
              - shell_command:
                - nvim ~/Second_Brain/areasOfResponsibility/Ekiree/Tech

          - window_name: nvim
            focus: true
            panes:
              - shell_command:
                - nvim ./ekiree_dashboard

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

      ".config/tmuxp/work.yaml".text =
        /*
        yaml
        */
        ''
          session_name: Work
          start_directory: ~/Documents/sre_lambda_layer/Github/axs-configurations

          windows:
          - window_name: notes
            focus: true
            panes:
              - shell_command:
                - nvim ~/Second_Brain

          - window_name: nvim
            panes:
              - shell_command:
                - nvim

          - window_name: git
            panes:
              - shell_command:
                - lazygit

          - window_name: term
            panes:
              - shell_command:
                - cd nixos
                - clear
        '';

      ".config/tmuxp/dashboard-config.yaml".text =
        /*
        yaml
        */
        ''
          session_name: Dashboard-Config
          start_directory: ~/Projects/dashboard/configuration

          windows:
          - window_name: notes
            panes:
            - shell_command:
              - nvim ~/Second_Brain/areasOfResponsibility/Ekiree/Tech

          - window_name: nvim
            focus: true
            panes:
            - shell_command:
              - nvim

          - window_name: term
            panes:
            - shell_command:
              - clear

          - window_name: git
            panes:
            - shell_command:
              - lazygit
        '';
    };
  };
}
