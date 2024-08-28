{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      tmux-navigator.enable = true;

      lazy.plugins = [
        {
          pkg = pkgs.vimPlugins.tmux-navigator;
          event = "VeryLazy";
        }
      ];

    };
  };
}
