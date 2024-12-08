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
            "vim"
            "regex"
            "lua"
            "bash"
            "markdown_inline"
            "yaml"
          ];
          indent.enable = true;
          highlight.enable = true;
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
