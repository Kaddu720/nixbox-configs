{pkgs, ...}: {
  imports = [
    ./completions.nix
    ./harpoon.nix
    ./lualine.nix
    ./neo-tree.nix
    ./obsidian.nix
    ./rosepine.nix
    ./telescope.nix
    ./treesitter.nix
  ];

  programs.nixvim.plugins = {
    lazy = {
      enable = true;
      plugins = [
        {
          pkg = pkgs.vimPlugins.comment-nvim;
          event = ["ModeChanged"];
        }
        {
          pkg = pkgs.vimPlugins.auto-pairs;
          event = ["BufNewFile" "BufReadPre"];
        }
        {
          pkg = pkgs.vimPlugins.tmux-navigator;
          lazy = true;
        }
        {
          pkg = pkgs.vimPlugins.which-key-nvim;
          lazy = false;
        }
      ];
    };
  };
}
