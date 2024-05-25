
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
                lualine.enable = true;
                telescope.enable = true;
                tmux-navigator.enable = true;
                fugitive.enable = true;
                harpoon.enable = true;
                neo-tree.enable = true;
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
            };

            autoCmd = [
                #Special commands for editing mark down
                {
                    event = [ "BufNewFile" "BufReadPost" ];
                    pattern = [ "*.txt" "*.md" ];
                    command = "set spell spellang=en_us";
                }
            ];
        };
    };
}
