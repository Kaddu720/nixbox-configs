{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      oil= {
        enable = true;
        settings = {
          default_file_explorer = true;
          experimental_watch_for_changes = true;
          float.border = "rounded";
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
        action = "<cmd>Oil --float<CR>";
        options.desc = "File Explorer";
      }
    ];
  };
}
