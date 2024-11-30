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
    programs.nushell = {
      enable = true;
      envFile.text = ''
        #enable zoxide
        zoxide init nushell | save -f ~/.zoxide.nu
      '';
      configFile.text = ''
        #enable zoxide
        source ~/.zoxide.nu
        alias cd = z
      '';
    };

    # extra nushell integrations
    programs = {
      zoxide.enableNushellIntegration = true;
      thefuck.enableNushellIntegration = true;
      starship.enableNushellIntegration = true;
      eza.enableNushellIntegration = true;
      direnv.enableNushellIntegration = true;
      carapace.enableNushellIntegration = true;
    };
  };
}
