{...}: {
  imports = [
    ./comment.nix
    ./completions.nix
    ./gitblame.nix
    ./harpoon.nix
    ./indent-blankline.nix
    ./lackluster.nix
    ./lualine.nix
    ./neo-tree.nix
    ./noice.nix
    ./nvim-autopairs.nix
    ./obsidian.nix
    ./oil.nix
    ./otter.nix
    ./rosepine.nix
    ./telescope.nix
    ./tmux-navigator.nix
    ./treesitter.nix
    ./trouble.nix
    ./web-devicons.nix
    ./which-key.nix
  ];

  programs.nixvim.plugins.lazy.enable = true;
}
