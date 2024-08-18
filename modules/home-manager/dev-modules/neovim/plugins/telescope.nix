{pkgs, ...}: {
  programs.nixvim = {
    plugins.lazy.plugins = [
      {
        name = "telescope-nvim";
        pkg = pkgs.vimPlugins.telescope-nvim;
        cmd.__raw = ''
          "Telescope"
        '';
        dependencies = [
          # required
          pkgs.vimPlugins.plenary-nvim
          # fzf optomizer plugin
          pkgs.vimPlugins.telescope-fzf-native-nvim
        ];
      }
    ];
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
