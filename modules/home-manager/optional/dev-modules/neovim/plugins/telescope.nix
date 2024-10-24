{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
          ui-select.enable = true;
        };
      };

      lazy.plugins = [
        {
          name = "telescope-nvim";
          pkg = pkgs.vimPlugins.telescope-nvim;
          cmd.__raw = ''
            "Telescope"
          '';
          dependencies = with pkgs.vimPlugins; [
            # required
            plenary-nvim
            # fzf optomizer plugin
            telescope-fzf-native-nvim
            # Ui for menues
            telescope-ui-select-nvim
            # web-devicons
            nvim-web-devicons
          ];
        }
      ];
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
        options.desc = "Telescop find files";
      }

      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<CR>";
        options.desc = "Telescop find buffers";
      }

      {
        mode = "n";
        key = "<leader>fw";
        action = "<cmd>Telescope live_grep<CR>";
        options.desc = "Telescop find words";
      }
    ];
  };
}
