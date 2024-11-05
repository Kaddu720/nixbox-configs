{
  pkgs,
  ...
}: let
  lackluster = pkgs.vimUtils.buildVimPlugin {
    name = "lackluster";
    src = pkgs.fetchFromGitHub {
      owner = "slugbyte";
      repo = "lackluster.nvim";
      rev = "6d206a3af7dd2e8389eecebab858e7d97813fc0c";
      hash = "sha256-bUN1FdIZnQ2upU5jW9eaal3sivMTRyrk4mptRqlktaA=";
    };
  };
in {
  programs.nixvim = {
    plugins.lazy.plugins = [
      {
        name = "lackluster";
        pkg = lackluster;
        lazy = false;
        priority = 1000;
      }
    ];
  };
}
