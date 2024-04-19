set fish_greeting " Praise the Omnissiah"
set -gx EDITOR nvim
source $HOME/.config/fish/functions/*

set HOME /home/noah
set SSH_ASKPASS ''

if status is-interactive
    # Commands to run in interactive sessions can go here
    # pywal
    cat /home/noah/.cache/wal/sequences
end
