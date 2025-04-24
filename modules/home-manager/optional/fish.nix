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
          alias cd "z"
        '';
    };

    # extra Fish integrations
    programs = {
      fzf.enableFishIntegration = true;
      zoxide.enableFishIntegration = true;
      thefuck.enableFishIntegration = true;
      starship.enableFishIntegration = true;
      eza.enableFishIntegration = true;
      carapace.enableFishIntegration = true;
    };

  };
}
