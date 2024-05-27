{ lib, config, ... }: {
    options = {
        nixvim.enable = 
            lib.mkEnableOption "enables nixvim";
    };

    config = lib.mkIf config.nixvim.enable {    
        programs.nixvim = {
    		enable = true;
    		defaultEditor = true;

            colorschemes.rose-pine.enable = true;

            plugins = {
                cmp.enable = true;
                fugitive.enable = true;
                harpoon.enable = true;
                lualine.enable = true;
                nvim-tree.enable = true;
                nvim-autopairs.enable = true;
                oil.enable = true;
                tmux-navigator.enable = true;
                which-key.enable = true;
                telescope = {
                    enable = true;
                    extensions.fzf-native.enable = true;
                };
                lsp = {
                    enable = true;
                    servers = {
                        pyright.enable = true; #python
                        nixd.enable = true; #nix
                        marksman.enable = true; #markdown
                    };
                };
            };

            opts = {
                number = true;
                relativenumber = true;

                expandtab = true; # convert tabs to spaces
                tabstop = 4; #tab shifts 4 spaces
                shiftwidth = 4; #make shift in vidual mode worth 4 spaces
                smartindent = true; #enable auto indent

                hlsearch = true; #highlight search results
                incsearch = true; #highlight objects as you search for them
                ignorecase = true; #case insensitive search 
                smartcase = true;

                showmode = false; #Let lualine provide status
            };

            autoCmd = [
                #Special commands for editing mark down
                {
                    event = [ "BufNewFile" "BufReadPost" ];
                    pattern = [ "*.txt" "*.md" ];
                    command = "set spell spelllang=en_us";
                }
            ];

            globals.mapleader = " ";
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

                {
                    mode = "n";
                    key = "<leader>ee";
                    action = "<cmd>NvimTreeToggle<CR>";
                    options.desc = "Toggle file exploere";
                }

                {
                    mode = "n";
                    key = "<leader>ef";
                    action = "<cmd>NvimTreeFindFileToggle<CR>";
                    options.desc = "Toggle file exploere on current location";
                }

                {
                    mode = "n";
                    key = "<leader>ec";
                    action = "<cmd>NvimTreeCollapse<CR>";
                    options.desc = "Collapse File Explorer";
                }

                {
                    mode = "n";
                    key = "<leader>er";
                    action = "<cmd>NvimTreeRrefresh<CR>";
                    options.desc = "Refresh File Exploerer";
                }
                
                {
                    mode = "n";
                    key = "<leader>o";
                    action = "<cmd>Oil<CR>";
                    options.desc = "Edit File system";
                }
            ];
        };
    };
}
