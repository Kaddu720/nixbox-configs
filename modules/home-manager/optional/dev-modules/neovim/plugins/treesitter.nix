{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        settings = {
          auto_install = true;
          ensure_installed = [
            "python"
            "nix"
            "markdown"
            "terraform"
            "sxhkdrc"
            # parsers for noice.nvim
            "vim"
            "regex"
            "lua"
            "bash"
            "markdown_inline"
          ];
          indent.enable = true;
          hightlight.enable = true;
        };
      };

      lazy.plugins = [
        {
          pkg = pkgs.vimPlugins.nvim-treesitter;
          event = ["BufNewFile" "BufReadPre"];
        }
      ];
    };
  };
}
