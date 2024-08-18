{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      lazy.plugins = [
        {
          pkg = pkgs.vimPlugins.harpoon;
          lazy = true;
          cmd.__raw = ''
            "Harpoon"
          '';
        }
      ];
    };
    keymaps = [
      # Harpoon
      {
        mode = "n";
        key = "<leader>hm";
        action = "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>";
        options.desc = "Harpoon Quick Menu";
      }

      {
        mode = "n";
        key = "<leader>ha";
        action = "<cmd>lua require('harpoon.mark').add_file()<CR>";
        options.desc = "Add a file to Harpoon";
      }

      {
        mode = "n";
        key = "<leader>h1";
        action = "<cmd>lua require('harpoon.ui').nav_file(1)<CR>";
        options.desc = "Navigate to file 1";
      }

      {
        mode = "n";
        key = "<leader>h2";
        action = "<cmd>lua require('harpoon.ui').nav_file(2)<CR>";
        options.desc = "Navigate to file 2";
      }

      {
        mode = "n";
        key = "<leader>h3";
        action = "<cmd>lua require('harpoon.ui').nav_file(3)<CR>";
        options.desc = "Navigate to file 3";
      }

      {
        mode = "n";
        key = "<leader>h4";
        action = "<cmd>lua require('harpoon.ui').nav_file(4)<CR>";
        options.desc = "Navigate to file 4";
      }
    ];
  };
}
