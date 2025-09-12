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
            alias cat "bat"

            # ripgrep
            alias grep "rg"

            # Command to activate vi mode
            set -g fish_key_bindings fish_vi_key_bindings

            # Command to fix auto complete in vi mode
            bind -M insert \cf accept-autosuggestion

            # enable fzf, the fuck, and zoxide
            alias cd "z"

            # Make kubeclt less of a pain to use
            alias k "kubectl"

            # Auto start sesh only if not already in tmux
            if test -z "$TMUX"
                set session_name (sesh list -icz | fzf-tmux -p 70%,80% \
                  --border=none \
                  --color='border:#e0def4,label:#e0def4,pointer:#f7768e' \
                  --list-label ' Sessions ' --list-border=rounded --layout=reverse --no-sort --ansi --prompt '>  ' \
                  --preview-window 'right:60%:rounded' \
                  --preview 'sesh preview {}')
                if test -n "$session_name"
                    sesh connect "$session_name"
                end
            end
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
      atuin = {
        enable = true;
        enableFishIntegration = true;
      };
      fzf.enableFishIntegration = true;
    };
  };
}
