{ pkgs, lib, config, ... }: {
    options = {
        dmenu.enable = 
            lib.mkEnableOption "enables dmenu";
    };

    config = lib.mkIf config.dmenu.enable {
        home.packages = let 
            dmenu = pkgs.dmenu.overrideAttrs (old: {
                # my own patched version of dmenu
                src = ../dmenu-5.3.tar.gz;
            });
        in with pkgs; [
            dmenu
        ];
    };
}
