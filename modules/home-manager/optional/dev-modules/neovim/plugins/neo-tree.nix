{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      neo-tree.enable = true;

      lazy.plugins = [
        {
          pkg = pkgs.vimPlugins.neo-tree-nvim;
          cmd.__raw = ''
            "Neotree"
          '';
          dependencies = with pkgs.vimPlugins; [
            # required
            plenary-nvim
            nui-nvim
            # web-devicons
            nvim-web-devicons
          ];
        }
      ];
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
