{pkgs, ...}: {
  imports = [
    ./markdown.nix
    ./nix.nix
    ./python.nix
    ./terraform.nix
  ];

  programs.nixvim = {
    plugins = {
      lazy.plugins = [
        {
          pkg = pkgs.vimPlugins.none-ls-nvim;
          event = ["BufNewFile" "BufReadPost"];
        }
      ];

      lsp = {
        enable = true;
        capabilities = "require('cmp_nvim_lsp').default_capabilities()";
        keymaps.lspBuf = {
          H = "hover";
          gd = "definition";
          "<leader>ca" = "code_action";
          "<leader>fm" = "format";
        };
      };

      none-ls.enable = true;

      ltex-extra.enable = true;
    };
  };
}
