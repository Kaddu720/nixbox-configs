{...}: {
  programs.nixvim = {
    plugins = {
      lsp = {
        servers = {
          nixd.enable = true; # nix
          nil_ls.enable = true;
        };
      };

      none-ls.sources = {
        formatting = {
          alejandra.enable = true; # nix formatting
        };
        diagnostics = {
          deadnix.enable = true; # nix diagnostics
        };
      };
    };
  };
}
