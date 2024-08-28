{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      which-key.enable = true;

      lazy.plugins = [
        {
          pkg = pkgs.vimPlugins.which-key-nvim;
          event = "VeryLazy";
        }
      ];
    };
  };
}
