{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      nvim-autopairs.enable = true;

      lazy.plugins = [
        {
          pkg = pkgs.vimPlugins.nvim-autopairs;
          event = ["InsertEnter"];
        }
      ];
    };
  };
}
