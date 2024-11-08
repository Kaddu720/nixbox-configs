
{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      comment.enable = true;

      lazy.plugins = [
        {
          pkg = pkgs.vimPlugins.comment-nvim;
          event = ["BufNewFile" "BufReadPre"];
        }
      ];
    };
  };
}
