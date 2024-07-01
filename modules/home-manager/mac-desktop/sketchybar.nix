
{ lib, config, ... }: {
    options = {
        sketchybar.enable = 
            lib.mkEnableOption "enables sketchybar";
    };

    config = lib.mkIf config.sketchybar.enable {    
        home.file = {
            ".config/sketchybar/sketchybarrc" = {
                source = ./sketchybarrc;
                executable = true;
            };
            ".config/sketchybar/plugins/battery.sh" = {
                source = ./plugins/battery.sh;
                executable = true;
            };
            ".config/sketchybar/plugins/clock.sh" = {
                source = ./plugins/clock.sh;
                executable = true;
            };
            ".config/sketchybar/plugins/front_app.sh" = {
                source = ./plugins/front_app.sh;
                executable = true;
            };
            ".config/sketchybar/plugins/space.sh" = {
                source = ./plugins/space.sh;
                executable = true;
            };
            ".config/sketchybar/plugins/volume.sh" = {
                source = ./plugins/volume.sh;
                executable = true;
            };
        };
    };
}
