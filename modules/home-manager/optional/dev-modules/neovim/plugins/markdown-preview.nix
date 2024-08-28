{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      markdown-preview.enable = true;

      lazy.plugins = [
        {
          pkg = pkgs.vimPlugins.markdown-preview-nvim;
          ft = "markdown";
        }
      ];
    };
  };
}
