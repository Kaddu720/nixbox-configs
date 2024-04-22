{ pkgs, lib, config, ... }: {
    options = {
        tmux.enable = 
            lib.mkEnableOption "enables tmux";
    };

    config = lib.mkIf config.neovim.enable {    
        programs.tmux = {
            enable = true;
            extraConfig = ''
                #Tmux package manager
                set -g @plugin 'tmux-plugins/tpm'
                set -g @plugin 'christoomey/vim-tmux-navigator'
                set -g @plugin 'tmux-plugins/tmux-yank'

                run '~/.config/tmux/plugins/tpm/tpm'

                #Status bar set at the top
                set-option -g status-position top

                #Mouse Support
                set -g mouse on

                #set vi-mode
                set-window-option -g mode-keys vi

                #Start Windows and panes at 1, not 0
                set -g base-index 1
                set -g pane-base-index 1
                set-window-option -g pane-base-index 1
                set-option -g renumber-windows on

                #Key bindings#
                # prefix key ix now C-b
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
                bind | split-window -h -c "#{pane_current_path}"
                bind - split-window -v -c "#{pane_current_path}"
                unbind '"'
                unbind %

                #adjust pane size with capital 'L" or "J"
                bind -n M-H resize-pane -L 5
                bind -n M-L resize-pane -R 5
                bind -n M-K resize-pane -U 5
                bind -n M-J resize-pane -D 5
            '';
        };
    };
}
