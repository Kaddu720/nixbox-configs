set fish_greeting " Praise the Omnissiah"
set -gx EDITOR nvim
source $HOME/.config/fish/functions/*

set HOME /home/noah
set SSH_ASKPASS ''

if status is-interactive
    # Commands to run in interactive sessions can go here

    # pywal
    cat /home/noah/.cache/wal/sequences
    set -gx BAT_THEME "base16"

    # Command to activate vi mode
    set -g fish_key_bindings fish_vi_key_bindings

    # Command to fix auto complete in vi mode
    bind -M insert \cf accept-autosuggestion

    #enable fzf, the fuck, and zoxide
    fzf --fish | source
    eval "$(thefuck --alias)"
    eval "$(zoxide init fish)"

end
