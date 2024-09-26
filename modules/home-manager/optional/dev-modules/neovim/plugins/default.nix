{...}: {
  imports = [
    ./comment.nix
    ./completions.nix
    ./harpoon.nix
    ./lualine.nix
    ./markdown-preview.nix
    ./neo-tree.nix
    ./noice.nix
    ./nvim-autopairs.nix
    ./obsidian.nix
    ./oil.nix
    ./rosepine.nix
    ./telescope.nix
    ./treesitter.nix
    ./web-devicons.nix
    ./which-key.nix
  ];

  programs.nixvim.plugins.lazy.enable = true;
}
