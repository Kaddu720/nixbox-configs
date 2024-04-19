{ pkgs, lib, config, ... }: {
    options = {
        fish.enable = 
            lib.mkEnableOption "enables fish shell";
    };

    config = lib.mkIf config.fish.enable {    
        home.file = {
            ".config/fish/functions".source = ./functions;
            ".config/fish/fish_variables".source = ./fish_variables;
            ".config/fish/config.fish".source = ./config.fish;
        };
    };
}
