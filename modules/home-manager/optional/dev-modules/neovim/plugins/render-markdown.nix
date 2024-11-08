{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      render-markdown.enable = true;

      lazy.plugins = [
        {
          pkg = pkgs.vimPlugins.render-markdown-nvim;
          ft = "markdown";
        }
      ];
    };
  };
}
