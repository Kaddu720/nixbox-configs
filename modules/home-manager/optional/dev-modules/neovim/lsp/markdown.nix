{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      lazy.plugins = [
        {
          pkg = pkgs.vimPlugins.ltex_extra-nvim;
          ft = "markdown";
        }
      ];

      lsp = {
        servers = {
          marksman.enable = true; # markdown

          ltex = {
            # spelling and grammer in markdown
            enable = true;
            settings = {
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
    };
  };
}
