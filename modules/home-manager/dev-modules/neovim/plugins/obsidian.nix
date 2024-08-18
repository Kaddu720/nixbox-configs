{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      lazy.plugins = [
        {
          pkg = pkgs.vimPlugins.obsidian-nvim;
          dependencies = [
            # required
            pkgs.vimPlugins.plenary-nvim
          ];
          lazy = true;
          ft = "markdown";
        }
      ];

      obsidian = {
        enable = true;
        settings = {
          workspaces = [
            {
              name = "Second_Brain";
              path = "~/Second_Brain";
            }
          ];
          completion = {
            min_chars = 2;
            nvim_cmp = true;
          };
          win_options = {
            conceallevel = 4;
          };
        };
      };
    };
  };
}
