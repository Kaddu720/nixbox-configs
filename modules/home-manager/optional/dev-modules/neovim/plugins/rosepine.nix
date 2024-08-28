{ pkgs, ... }: {
    programs.nixvim = {
        colorschemes.rose-pine = {
            enable = true;
            settings = {
                styles = {
                    transparency = true;
                };
            };
        };

        plugins.lazy.plugins = [
            {
                name = "rose-pine";
                pkg = pkgs.vimPlugins.rose-pine;
                lazy = false;
                priority = 1000;
            }
        ];
    };
}
