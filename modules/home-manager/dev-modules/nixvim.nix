{ lib, config, ... }: {
    options = {
        nixvim.enable = 
            lib.mkEnableOption "enables nixvim";
    };
    config = lib.mkIf config.nixvim.enable {    
        programs.nixvim = {
    		enable = true;
    		defaultEditor = true;

            colorschemes.rose-pine = {
                enable = true;
                settings = {
                    styles = {
                        transparency = true;
                    };
                };
            };

            plugins = {
                commentary.enable = true;
                harpoon.enable = true;
                lualine.enable = true;
                nvim-tree.enable = true;
                nvim-autopairs.enable = true;
                #obsidian.enable = true;
                oil.enable = true;
                tmux-navigator.enable = true;
                treesitter = {
                    enable = true;
                    settings.indent.enable = true;
                };
                telescope = {
                    enable = true;
                    extensions.fzf-native.enable = true;
                };
                which-key.enable = true;

                # Completion
                cmp = {
                    enable = true;
                    autoEnableSources = false;
                    settings = {
                        mapping = {
                            __raw = /*lua*/ ''
                                cmp.mapping.preset.insert({
                                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                                    ['<C-Space>'] = cmp.mapping.complete(),
                                    ['<C-e>'] = cmp.mapping.abort(),
                                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                                })
                            '';
                        };
                        snippet = {
                            expand = "function(args) require('luasnip').lsp_expand(args.body) end";
                        };
                        sources = {
                            __raw = /*lua*/ ''
                                cmp.config.sources({
                                    { name = 'nvim_lsp' },
                                    { name = 'luasnip' },
                                }, {
                                    { name = 'buffer' },nixvim
                            })
                        '';
                        window.completion.border = [ "rounded" ];
                        window.documenation.border = [ "rounded" ];
                      };
                    };
                };
                cmp-nvim-lsp.enable = true;
                cmp-treesitter.enable = true;
                friendly-snippets.enable = true;
                luasnip.enable = true;
                cmp_luasnip.enable = true;

                # Language Servers
                lsp = {
                    enable = true;
                    capabilities = "require('cmp_nvim_lsp').default_capabilities()";
                    servers = {
                        pyright.enable = true; #python
                        nixd.enable = true; #nix
                        marksman.enable = true; #markdown
                        terraformls.enable = true; #terraform
                        #tailwindcss.enable = true; #tailwind css
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

            clipboard.providers.xclip.enable = true;

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

                # Completion


                # Telescope
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

                # Harpoon
                {
                    mode = "n";
                    key = "<leader>hm";
                    action = "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>";
                    options.desc = "Harpoon Quick Menu";
                }

                {
                    mode = "n";
                    key = "<leader>ha";
                    action = "<cmd>lua require('harpoon.mark').add_file()<CR>";
                    options.desc = "Add a file to Harpoon";
                }

                {
                    mode = "n";
                    key = "<leader>h1";
                    action = "<cmd>lua require('harpoon.ui').nav_file(1)<CR>";
                    options.desc = "Navigate to file 1";
                }

                {
                    mode = "n";
                    key = "<leader>h2";
                    action = "<cmd>lua require('harpoon.ui').nav_file(2)<CR>";
                    options.desc = "Navigate to file 2";
                }

                {
                    mode = "n";
                    key = "<leader>h3";
                    action = "<cmd>lua require('harpoon.ui').nav_file(3)<CR>";
                    options.desc = "Navigate to file 3";
                }

                {
                    mode = "n";
                    key = "<leader>h4";
                    action = "<cmd>lua require('harpoon.ui').nav_file(4)<CR>";
                    options.desc = "Navigate to file 4";
                }

                # Nvim Tree
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
