{ pkgs, lib, config, ... }: {
    options = {
        dwmblocks.enable = 
            lib.mkEnableOption "enables dwmblocks";
    };

    config = lib.mkIf config.dwmblocks.enable {
        home.packages = let 
            dwmblocks = pkgs.dwmblocks.override {
                conf = ./blocks.def.h;
                patches = [ ];
            };
        in with pkgs; [
            dwmblocks
        ];
    };
}
