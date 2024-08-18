{ pkgs, ... }: {
    programs.nixvim = {
        plugins = {
            lazy.plugins = [
                {
                    pkg = pkgs.vimPlugins.nvim-treesitter;
                    event = ["BufNewFile" "BufReadPre"];
                }
            ];

            treesitter = {
                enable = true;
                settings = {
                    auto_install = true;
                    ensure_installed = [ 
                        "python" 
                        "nix"
                        "markdown"
                        "terraform"
                    ];
                    indent.enable = true;
                    hightlight.enable = true;
                };
            };
        };
    };
}
