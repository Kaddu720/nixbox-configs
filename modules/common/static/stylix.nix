{
  config,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;
    image = ./dark_fractal.jpg;
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "Jetbrains Mono";
      };
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji = config.stylix.fonts.monospace;
    };
    base16Scheme = {
      base00 = "#191724";
      base01 = "#aa7264";
      base02 = "#bb5c3a";
      base03 = "#c78645";
      base04 = "#3b83aa";
      base05 = "#8c9aa5";
      base06 = "#563ea9";
      base07 = "#c7c4c4";
      base08 = "#b4637a";
      base09 = "#aa7264";
      base0A = "#bb5c3a";
      base0B = "#c78645";
      base0C = "#3b83aa";
      base0D = "#3b83aa";
      base0E = "#563ea9";
      base0F = "#c7c4c4";
    };
    targets.gtk.enable = pkgs.lib.mkIf pkgs.stdenv.isLinux true;
    targets.kde.enable = pkgs.lib.mkIf pkgs.stdenv.isLinux true;
  };
}
