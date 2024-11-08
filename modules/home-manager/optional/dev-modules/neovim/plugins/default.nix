{...}: {
  imports = [
    ./comment.nix
    ./completions.nix
    ./gitblame.nix
    ./harpoon.nix
    ./lackluster.nix
    ./lualine.nix
    ./neo-tree.nix
    ./noice.nix
    ./nvim-autopairs.nix
    ./obsidian.nix
    ./oil.nix
    ./render-markdown.nix
    ./rosepine.nix
    ./telescope.nix
    ./treesitter.nix
    ./web-devicons.nix
    ./which-key.nix
  ];

  programs.nixvim.plugins.lazy.enable = true;
}
