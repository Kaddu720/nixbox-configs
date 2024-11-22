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
    programs.fish = {
      enable = true;
      interactiveShellInit =
        /*
        fish
        */
        ''
          set fish_greeting " Praise the Omnissiah"

          # bat color scheme
          set -gx BAT_THEME "base16"

          # Command to activate vi mode
          set -g fish_key_bindings fish_vi_key_bindings

          # Command to fix auto complete in vi mode
          bind -M insert \cf accept-autosuggestion

          # enable fzf, the fuck, and zoxide
          fzf --fish | source
          eval "$(thefuck --alias)"
          eval "$(zoxide init fish)"
          alias cd "z"
        '';
    };

    home.file = {
      ".config/fish/fish_variables".text =
        /*
        fish
        */
        ''
          # This file contains fish universal variable definitions.
          # VERSION: 3.0
          SETUVAR __fish_initialized:3400
          SETUVAR _fish_abbr_list:ls
          SETUVAR _fish_abbr_logout:dm\x2dtool\x20switch\x2dto\x2dgreeter
          SETUVAR chain_links:chain\x2elinks\x2eroot\x1echain\x2elinks\x2ejobs\x1echain\x2elinks\x2epwd\x1echain\x2elinks\x2evcs_branch\x1echain\x2elinks\x2evcs_dirty\x1echain\x2elinks\x2evcs_stashed

          #Fish Keybindings
          SETUVAR fish_key_bindings:fish_default_key_bindings

          # Fish shell colors
          SETUVAR fish_color_autosuggestion:555\x1ebrblack
          SETUVAR fish_color_cancel:\x2dr
          SETUVAR fish_color_command:005fd7
          SETUVAR fish_color_comment:990000
          SETUVAR fish_color_cwd:green
          SETUVAR fish_color_cwd_root:red
          SETUVAR fish_color_end:009900
          SETUVAR fish_color_error:ff0000
          SETUVAR fish_color_escape:00a6b2
          SETUVAR fish_color_history_current:\x2d\x2dbold
          SETUVAR fish_color_host:normal
          SETUVAR fish_color_host_remote:yellow
          SETUVAR fish_color_normal:normal
          SETUVAR fish_color_operator:00a6b2
          SETUVAR fish_color_param:00afff
          SETUVAR fish_color_quote:999900
          SETUVAR fish_color_redirection:00afff
          SETUVAR fish_color_search_match:bryellow\x1e\x2d\x2dbackground\x3dbrblack
          SETUVAR fish_color_selection:white\x1e\x2d\x2dbold\x1e\x2d\x2dbackground\x3dbrblack
          SETUVAR fish_color_status:red
          SETUVAR fish_color_user:brgreen
          SETUVAR fish_color_valid_path:\x2d\x2dunderline
          SETUVAR fish_pager_color_completion:\x1d
          SETUVAR fish_pager_color_description:B3A06D\x1eyellow
          SETUVAR fish_pager_color_prefix:normal\x1e\x2d\x2dbold\x1e\x2d\x2dunderline
          SETUVAR fish_pager_color_progress:brwhite\x1e\x2d\x2dbackground\x3dcyan
          SETUVAR fish_pager_color_selected_background:\x2dr
        '';
    };
  };
}
