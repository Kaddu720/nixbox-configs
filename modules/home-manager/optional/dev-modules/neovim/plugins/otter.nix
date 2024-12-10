{pkgs, ...}: {
  programs.nixvim = {
    # make otter transpraent for rose pine
    plugins = {
      otter = {
        enable = true;
      };

      lazy.plugins = [
        {
          pkg = pkgs.vimPlugins.otter-nvim;
          ft = "nix";
          dependencies = with pkgs.vimPlugins; [
            nvim-cmp
            nvim-lspconfig
            nvim-treesitter
          ];
        }
      ];
    };
  };
}
