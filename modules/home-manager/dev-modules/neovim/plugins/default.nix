{...}: {
  imports = [
    ./comment.nix
    ./completions.nix
    ./harpoon.nix
    ./lualine.nix
    ./neo-tree.nix
    ./noice.nix
    ./nvim-autopairs.nix
    ./obsidian.nix
    ./oil.nix
    ./rosepine.nix
    ./telescope.nix
    ./treesitter.nix
    ./which-key.nix
  ];

  programs.nixvim.plugins.lazy.enable = true;
}
