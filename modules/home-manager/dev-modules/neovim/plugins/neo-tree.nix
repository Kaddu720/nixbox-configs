{ pkgs, ... }: {
    programs.nixvim = {
        plugins = {
            lazy.plugins = [
                {
                    pkg = pkgs.vimPlugins.neo-tree-nvim;
                    cmd.__raw = ''
                        "Neotree"
                    '';
                    dependencies = [
                        # required
                        pkgs.vimPlugins.plenary-nvim
                        pkgs.vimPlugins.nui-nvim
                    ];
                }
            ];

            neo-tree.enable = true; 
        };
    keymaps = [
        {
          mode = "n";
          key = "<leader>ee";
          action = "<cmd>Neotree toggle<CR>";
          options.desc = "Toggle file exploere";
        }

        {
          mode = "n";
          key = "<leader>ef";
          action = "<cmd>Neotree filesystem reveal left<CR>";
          options.desc = "Toggle file exploere on current location";
        }

        {
          mode = "n";
          key = "<leader>er";
          action = "<cmd>NvimTreeRrefresh<CR>";
          options.desc = "Refresh File Exploerer";
        }
      ];
    };
}
