{
  config,
  pkgs,
  ...
}: {
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
          follow_url_func.__raw = ''
            function(url)
              vim.fn.jobstart({"xdg-open", url})
            end
          '';
          templates.subdir =
            if "${config.home.username}" == "noahwilson"
            then "~/WorkBrain/resources/templates"
            else "~/Second_Brain/resources/templates";
        };
      };
    };
  };
}
