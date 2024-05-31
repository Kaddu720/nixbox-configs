{ pkgs, lib, config, ... }: {
    options = {
        dwl.enable = 
            lib.mkEnableOption "enables dwl";
    };

    config = lib.mkIf config.dwl.enable {
        home.packages = let 
            dwl = pkgs.dwl.override {
                conf = ./config.def.h;
            };
        in with pkgs; [
            dwl
            yambar
        ];
    };
}
