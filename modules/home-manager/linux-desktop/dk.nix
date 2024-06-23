{ pkgs, lib, config, ... }: {
    options = {
        dk.enable = 
            lib.mkEnableOption "enables dk";
    };

    config = lib.mkIf config.dk.enable {
        home = {
            packages = with pkgs; [
                dk
            ];
            file.".config/dk/dkrc" = {
                source = ./dkrc;
                executable = true;
            };
        };
    };
}
