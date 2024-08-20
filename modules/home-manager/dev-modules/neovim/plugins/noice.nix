{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      noice.enable = true;

      lazy.plugins = [
        {
          pkg = pkgs.vimPlugins.noice-nvim;
          event = ["VeryLazy"];
          dependencies = [
            # required
            pkgs.vimPlugins.nui-nvim
          ];
        }
      ];
    };
  };
}
