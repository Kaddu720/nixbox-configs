{ lib, config, ... }: {
    options = {
        skhd.enable = 
            lib.mkEnableOption "enables skhd";
    };

    config = lib.mkIf config.skhd.enable {    
        home.file.".config/skhd/skhdrc" = {
            text = ''
                # open terminal
                alt - return : open -n -a alacritty

                # open brower
                alt - w : open -n -a "Zen Browser"
            '';
            executable = true;
        };
    };
}
