
{ pkgs, lib, config, ... }: {
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
                fugitive.enable = true;
                harpoon.enable = true;
                lualine.enable = true;
                nvim-tree.enable = true;
                telescope.enable = true;
                tmux-navigator.enable = true;
                lsp = {
                    enable = true;
                    servers = {
                        pyright.enable = true; #python
                        nixd.enable = true; #nix
                        marksman.enable = true; #markdown
                    };
                };
            };

            options = {
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
                    key = "<leader>tf";
                    action = "<cmd>Telescope find_files<CR>";
                    options.desc = "Telescop find files";
                }

                {
                    mode = "n";
                    key = "<leader>tb";
                    action = "<cmd>Telescope buffers<CR>";
                    options.desc = "Telescop find buffers";
                }

                {
                    mode = "n";
                    key = "<leader>tg";
                    action = "<cmd>Telescope live_grep<CR>";
                    options.desc = "Telescop search for words in files";
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
            ];
        };
    };
}
