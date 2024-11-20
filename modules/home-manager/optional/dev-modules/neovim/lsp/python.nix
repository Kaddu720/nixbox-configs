{...}: {
  programs.nixvim = {
    plugins = {
      lsp = {
        servers = {
          pyright.enable = true; # python lsp
          ruff.enable = true; # python linter
        };
      };

      none-ls.sources = {
        formatting = {
          isort.enable = true; # python linting and format sorting
        };
        diagnostics = {
          mypy.enable = true; # python diagnostics
        };
      };
    };
  };
}
