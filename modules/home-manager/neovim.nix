{ pkgs, lib, config, ... }: {
    options = {
        neovim.enable = 
            lib.mkEnableOption "enables neovim";
    };

    config = lib.mkIf config.neovim.enable {    
        programs.neovim = {
            enable = true;
            defaultEditor = true;
            plugins = with pkgs.vimPlugins; [
                pywal-nvim
                vim-tmux-navigator
                wal-vim
                rose-pine
                lightline-vim
                vim-fugitive
                fzf-vim
            ];
            extraConfig = ''
                syntax on " enables syntax highlighting
                set rnu " relative line numbers
                set number " show current line number
                set expandtab " converts tabs to spaces
                set tabstop=4 " makes each tab worth 4 spaces
                set shiftwidth=4 " makes the shifts in visual mode worth 4 spaces
                set hlsearch " high lights search results
                set incsearch " highlights objects you're searching for as you type
                set smartindent "enable auto indent
                set mouse=a "enable mouse support

                set ignorecase "case insentive search unless capital letter are used
                set smartcase
                set incsearch "highlights the amtch text pattern when searching

                " turn on spell check on new text files
                autocmd BufNewFile *.txt,*.md set spell spelllang=en_us
                " turn on spell check on exsiting text files
                autocmd BufReadPost *.txt,*.md set spell spelllang=en_us
                " spell check command is `z=`

                "setting up .nix file recognition
                au BufRead, BufNewFile *.nix set filetype=nix

                "Key mapping so that k and j will move through visual lines instead of logical
                "lines
                noremap <silent> k gk
                noremap <silent> j gj
                "Key mapping to turn of the arrow buttons
                noremap  <Up> ""
                noremap! <Up> <Esc>
                noremap  <Down> ""
                noremap! <Down> <Esc>
                noremap  <Left> ""
                noremap! <Left> <Esc>
                noremap  <Right> ""
                noremap! <Right> <Esc>


                " configuring text colors
                colorscheme rose-pine-main

                " Congfigure light line
                let g:lightline = {
                      \ 'colorscheme': 'rosepine',
                      \ 'active': {
                      \   'left': [ [ 'mode', 'paste' ],
                      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
                      \ },
                      \ 'component_function': {
                      \   'gitbranch': 'FugitiveHead'
                      \ },
                      \ }

                "disable regular vim status bar so lightbar can work
                set noshowmode

                " vscode integration
                if exists('g:vscode')
                    " VSCode extension
                else
                    " ordinary Neovim
                endif
            '';
        };
    };
}
