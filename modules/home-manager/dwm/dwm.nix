{ pkgs, lib, config, ... }: {
    options = {
        dwm.enable = 
            lib.mkEnableOption "enables dwm";
    };

    config = lib.mkIf config.dwm.enable {
        home.packages = let 
            dwm = pkgs.dwm.override {
                conf = ./config.def.h;
                patches = [
                    # dwm alpha patch
                    ./patches/dwm-alpha-20230401-348f655.diff
                    #dwm full gaps patch
                    ./patches/dwm-fullgaps-6.4.diff
                    # dwm home made pywal patch
                    ./patches/dwm-wal-6.5.diff
                    # status bar on all monitors
                    ./patches/dwm-statusallmons-6.2.diff
                    # center all floating monitors
                    ./patches/dwm-alwayscenter-20200625-f04cac6.diff
                    # scratch pad
                    ./patches/dwm-scratchpad-20240321-061e9fe.diff
                ];
            };
        in with pkgs; [
            dwm
        ];
    };
}
