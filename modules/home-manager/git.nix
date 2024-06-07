
{ pkgs, lib, config, ... }: {
    options = {
        git.enable = 
            lib.mkEnableOption "enables git";
    };

    config = lib.mkIf config.git.enable {    
        programs.git = {
            enable = true;
            userName = "Kaddu720";
            userEmail = "nwilsonmalgus@gmail.com";
            extraConfig = {
                pull.rebase = true;
            };
        };
    };
}

