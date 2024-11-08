{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      cmp = {
        enable = true;
        autoEnableSources = false;
        settings = {
          mapping = {
            __raw =
              /*
              lua
              */
              ''
                cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                })
              '';
          };
          snippet = {
            expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          };
          sources = {
            __raw =
              /*
              lua
              */
              ''
                    cmp.config.sources({
                        { name = 'nvim_lsp' },
                        { name = 'luasnip' },
                    }, {
                        { name = 'buffer' },nixvim
                })
              '';
            window = {
              completion = {border = "solid";};
              documentation = {border = "solid";};
            };
          };
        };
      };
      cmp-nvim-lsp.enable = true;
      cmp-treesitter.enable = true;
      #friendly-snippets.enable = true;
      luasnip.enable = true;
      cmp_luasnip.enable = true;

      lazy.plugins = [
        {
          pkg = pkgs.vimPlugins.nvim-cmp;
          event = ["InsertEnter"];
          dependencies = with pkgs.vimPlugins; [
            cmp-nvim-lsp
            cmp-treesitter
            #pkgs.vimPlugins.friendly-snippets
            luasnip
            cmp_luasnip
          ];
        }
      ];
    };
  };
}
