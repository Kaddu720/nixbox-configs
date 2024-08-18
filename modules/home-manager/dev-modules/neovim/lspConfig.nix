{...}: {
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        capabilities = "require('cmp_nvim_lsp').default_capabilities()";
        keymaps.lspBuf = {
          K = "hover";
          gd = "definition";
          "<leader>ca" = "code_action";
          "<leader>fm" = "format";
        };
        servers = {
          pyright.enable = true; #python
          nixd.enable = true; #nix
          marksman.enable = true; #markdown
          terraformls.enable = true; #terraform
          #tailwindcss.enable = true; #tailwind css
        };
      };
      none-ls = {
        # utility lsp
        enable = true;
        sources.formatting = {
          alejandra.enable = true; # nix formatting

          black.enable = true; # python formatting
          isort.enable = true; # python linting
        };
      };
    };
  };
}
