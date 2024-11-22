{pkgs, ...}: {
  programs.nixvim = {
    # make trouble transpraent for rose pine
    plugins = {
      trouble = {
        enable = true;
        settings = {
          auto_close = true;
          auto_jumpt = true;
        };
      };

      lazy.plugins = [
        {
          pkg = pkgs.vimPlugins.trouble-nvim;
          event = ["VeryLazy"];
        }
      ];
    };

    keymaps = [
      # Toggle Trouble
      {
        mode = "n";
        key = "<leader>tt";
        action = "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>";
        options.desc = "Diagnostics (Trouble)";
      }

      # Toogle Focus
      {
        mode = "n";
        key = "<leader>tf";
        action = "<cmd>Trouble diagnostics focus=true<cr>";
        options.desc = "Focus on Diagnostics (Trouble)";
      }
    ];
  };
}
