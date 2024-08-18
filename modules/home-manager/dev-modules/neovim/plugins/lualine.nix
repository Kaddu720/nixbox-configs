{ pkgs, ... }: {
    programs.nixvim = {
        plugins = {
            lazy.plugins = [
                {
                    pkg = pkgs.vimPlugins.lualine-nvim;
                    lazy = false;
                }
            ];

            lualine.enable = true; 
        };
    };
}
