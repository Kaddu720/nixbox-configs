{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      gitblame.enable = true;

      lazy.plugins = [
        {
          pkg = pkgs.vimPlugins.git-blame-nvim;
          event = ["VeryLazy"];
        }
      ];
    };
  };
}
