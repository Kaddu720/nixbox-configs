{...}: {
  programs.nixvim = {
    plugins = {
      lsp = {
        servers = {
          nixd.enable = true; # nix
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
