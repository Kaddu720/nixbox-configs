{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      indent-blankline.enable = true;

      lazy.plugins = [
        {
          pkg = pkgs.vimPlugins.indent-blankline-nvim;
          event = ["BufNewFile" "BufReadPre"];
        }
      ];
    };
  };
}
