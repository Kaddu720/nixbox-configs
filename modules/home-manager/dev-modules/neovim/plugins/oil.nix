{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      oil= {
        enable = true;
        settings = {
          default_file_explorer = true;
          experimental_watch_for_changes = true;
        };
      };

      lazy.plugins = [
        {
          pkg = pkgs.vimPlugins.oil-nvim;
          event = ["VeryLazy"];
        }
      ];
    };

    keymaps = [
      {
        mode = "n";
        key = "-";
        action = "<cmd>Oil<CR>";
        options.desc = "File Explorer";
      }
    ];
  };
}
