{pkgs, ...}: {
  programs.nixvim = {
    # make trouble transpraent for rose pine
    plugins = {
      trouble = {
        enable = true;
      };

      lazy.plugins = [
        {
          pkg = pkgs.vimPlugins.trouble-nvim;
          event = ["VeryLazy"];
        }
      ];
    };
  };
}
