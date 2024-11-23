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
    home.packages = with pkgs; [tmuxifier];

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
      ".tmux-layouts/dashboard.session.sh".text =
        /*
        bash
        */
        ''
          # Set a custom session root path. Default is `$HOME`.
          # Must be called before `initialize_session`.
          session_root "~/Projects/dashboard/dev/ekiree_dashboard"

          # Create session with specified name if it does not already exist. If no
          # argument is given, session name will be based on layout file name.
          if initialize_session "dashboard"; then

            # Create a new window inline within session layout definition.
            new_window "notes"
            run_cmd "nvim ~/Second_Brain/areasOfResponsibility/Ekiree/Tech"

            new_window "nvim"
            run_cmd "nvim ./ekiree_dashboard"

            new_window "git"
            run_cmd "lazygit"

            new_window "term"
            run_cmd "cd ekiree_dashboard"

            # Select the default active window on session creation.
            select_window 2

          fi

          # Finalize session creation and switch/attach to it.
          finalize_and_go_to_session
        '';
      ".tmux-layouts/axs.session.sh".text =
        /*
        bash
        */
        ''
          # Set a custom session root path. Default is `$HOME`.
          # Must be called before `initialize_session`.
          session_root "~/Documents/Github/axs-configurations"

          # Create session with specified name if it does not already exist. If no
          # argument is given, session name will be based on layout file name.
          if initialize_session "AXS"; then

            # Create a new window inline within session layout definition.
            new_window "notes"
            run_cmd "/Users/noahwilson/WorkBrain"
            run_cmd "nvim ."

            new_window "nvim"
            run_cmd "nvim ."

            new_window "git"
            run_cmd "lazygit"

            new_window "term"
            run_cmd "cd nixos"
            run_cmd "clear"

            # Select the default active window on session creation.
            select_window 1

          fi

          # Finalize session creation and switch/attach to it.
          finalize_and_go_to_session
        '';
    };
  };
}
