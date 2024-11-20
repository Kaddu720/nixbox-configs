{...}: {
  programs.nixvim = {
    plugins = {
      lsp = {
        servers = {
          terraformls.enable = true; # terraform
          tflint.enable = true; # terraform linting
        };
      };
    };
  };
}
