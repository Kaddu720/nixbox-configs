{pkgs, ...}: {
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
          #pyright.enable = true; # python
          basedpyright.enable = true; # python lsp
          ruff.enable = true; # python linter

          terraformls.enable = true; # terraform
          tflint.enable = true; # terraform linting

          nixd.enable = true; # nix
          marksman.enable = true; # markdown
          #tailwindcss.enable = true; # tailwind css
          ltex = { # spelling and grammer in markdown
            enable = true;             settings = {
              language = "en-US";
              enabled = true;
              dictionary = {
                "en-us".__raw = "spell_words";
              };
              checkFrequency = "save";
            };
          };
        };
      };
      none-ls = {
        # utility lsp
        enable = true;
        sources = {
          formatting = {
            alejandra.enable = true; # nix formatting

            black.enable = true; # python formatting
            isort.enable = true; # python linting
          };
          diagnostics = {
            mypy.enable = true;
          };
        };
      };

      ltex-extra.enable = true;
    };
  };
}
