{ pkgs, lib, config, ... }: {
    options = {
        xserver.enable = 
            lib.mkEnableOption "enables xserver";
    };

    config = lib.mkIf config.xserver.enable {    
        services.libinput.enable = true;
        services.xserver = {
            enable = true;
            displayManager.startx.enable = true;
            xkb.layout = "us";
            xkb.options = "eurosign:e,caps:escape";
            videoDrivers = ["andgpu"];
        };
    };
}
