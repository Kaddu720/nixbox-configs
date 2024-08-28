{
  pkgs,
  ...
}: {

  programs.nixvim = {
    plugins = {
      lazy.plugins = [
        {
          pkg = pkgs.vimPlugins.none-ls-nvim;
          event = ["BufNewFile" "BufReadPre"];
        }
        {
          pkg = pkgs.vimPlugins.ltex_extra-nvim;
          ft = "markdown";
        }
      ];

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
          ltex = {
            enable = true; # spelling and grammer in markdown
            settings = {
              language = "en-US";
              enabled = true;
              dictionary = {
                "en-us".__raw = "spell_words";
              };
            };
          };
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

      ltex-extra.enable = true;
    };
  };
}
