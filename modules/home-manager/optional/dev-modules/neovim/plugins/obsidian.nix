{
  config,
  pkgs,
  ...
}: {
  programs.nixvim = {
    plugins = {
      obsidian = {
        enable = true;
        settings = {
          workspaces =
            if "${config.home.username}" == "noahwilson"
            then [
              {
                name = "WorkBrain";
                path = "~/WorkBrain";
              }
            ]
            else [
              {
                name = "Second_Brain";
                path = "~/Second_Brain";
              }
            ];
          completion = {
            min_chars = 2;
            nvim_cmp = true;
          };
          follow_url_func.__raw =
            if "${config.home.username}" == "noahwilson"
            then ''
              function(url)
                vim.fn.jobstart({"open", url})  -- Mac OS
              end
            ''
            else ''
              function(url)
                vim.fn.jobstart({"xdg-open", url}) -- linux
              end
            '';
          templates.subdir =
            if "${config.home.username}" == "noahwilson"
            then "~/WorkBrain/resources/templates"
            else "~/Second_Brain/resources/templates";
        };
      };

      lazy.plugins = [
        {
          pkg = pkgs.vimPlugins.obsidian-nvim;
          dependencies = [
            # required
            pkgs.vimPlugins.plenary-nvim
          ];
          ft = "markdown";
        }
      ];
    };

    keymaps = [
      # Obsidian
      {
        mode = "n";
        key = "<leader>ot";
        action = "<cmd>ObsidianTemplate<CR>";
        options.desc = "Obsidian Template Menu";
      }
      {
        mode = "n";
        key = "<leader>os";
        action = "<cmd>! ./sync<CR>";
        options.desc = "Obsidian Sync";
      }
      {
        mode = "n";
        key = "<leader>od";
        action = "<cmd>ObsidianDailies<CR>";
        options.desc = "Obsidian Daily";
      }
    ];
  };
}
