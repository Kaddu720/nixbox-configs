{ pkgs, lib, config, ... }: {
    options = {
        sxhkd.enable = 
            lib.mkEnableOption "enables sxhkd";
    };

    config = lib.mkIf config.sxhkd.enable {
        #services.sxhkd = {
        #    enable = true;
        #};

        home.packages = with pkgs; [ sxhkd ];
        home.file.".config/sxhkd/sxhkdrc" = {
            source = ./sxhkdrc;
            executable = true;
        };
    };
}
