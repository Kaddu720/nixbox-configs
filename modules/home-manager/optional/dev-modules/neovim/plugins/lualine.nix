{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      lualine.enable = true;

      lazy.plugins = [
        {
          pkg = pkgs.vimPlugins.lualine-nvim;
          lazy = false;
        }
      ];
    };
  };
}
