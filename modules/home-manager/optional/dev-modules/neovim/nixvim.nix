{
  lib,
  config,
  ...
}: {
  imports = [
    ./plugins
    ./lspConfig.nix
  ];

  options = {
    nixvim.enable =
      lib.mkEnableOption "enables nixvim";
  };
  config = lib.mkIf config.nixvim.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;

      opts = {
        number = true;
        relativenumber = true;

        expandtab = true; # convert tabs to spaces
        tabstop = 2; #tab shifts 2 spaces
        shiftwidth = 2; #make shift in visual mode worth 2 spaces
        smartindent = true; #enable auto indent

        hlsearch = true; #highlight search results
        incsearch = true; #highlight objects as you search for them
        ignorecase = true; #case insensitive search
        smartcase = true; # Case matters if I use a capital letter
        inccommand = "split"; # gives me a preview of what commands will look like when executed

        showmode = false; #Let lualine provide status

        conceallevel = 2; # let obsidian coneal text with ui

        splitright = true; # when opening a split, fous on right window
        splitbelow = true; # when opening a split, focus on bottom window

        swapfile = false;
      };

      clipboard.providers.xclip.enable = true;

      autoCmd = [
        #Special commands for editing mark down
        {
          event = ["BufNewFile" "BufReadPost"];
          pattern = ["*.txt" "*.md"];
          command = "set spell spelllang=en_us";
        }
      ];

      globals.mapleader = " ";
      keymaps = [
        # Page up and down navigation
        {
          key = "<C-d>";
          action = "<C-d>zz";
          options.noremap = true;
        }

        {
          key = "<C-u>";
          action = "<C-u>zz";
          options.noremap = true;
        }

        # Center page when searching
        {
          key = "<n>";
          action = "<nzzzv";
          options.noremap = true;
        }

        {
          key = "<N>";
          action = "<Nzzzv";
          options.noremap = true;
        }

        # Traverse soft wrapped lines
        {
          key = "j";
          action = "gj";
          options.noremap = true;
        }

        {
          key = "k";
          action = "gk";
          options.noremap = true;
        }

        # Open Splits
        {
          mode = "n";
          key = "<leader>sv";
          action = "<cmd>vsplit<CR>";
          options.desc = "Open Vertical Split";
        }

        {
          mode = "n";
          key = "<leader>sh";
          action = "<cmd>split<CR>";
          options.desc = "Open Horizontal Split";
        }
        
      ];
    };
  };
}
