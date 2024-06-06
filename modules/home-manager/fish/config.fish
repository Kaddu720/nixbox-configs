set fish_greeting " Praise the Omnissiah"
set -gx EDITOR nvim
source $HOME/.config/fish/functions/*

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

    #aliases
    alias cd "z"
end

#Fucntions
#Wifi Function
function dmenu-wifi
    set bssid $(nmcli device wifi list | sed -n '1!p' | cut -b 9- | dmenu -p "Select wifi" -l 20  | cut -d ' ' -f1)
    set pass $(echo "" 	| dmenu -p "Enter Password : ")
    nmcli device wifi connect $bssid password $pass 
    pkill -RTMIN+9 dwmblocks
end

#Pipe wire sinck selector
function dmenu-sound
    set sink $( wpctl status -k | grep -m 1 'Sinks:' --no-group-separator -A2 | grep -v 'Sinks' | cut -b 7-30 | dmenu -p "selct Audio Output" -l 2 | cut -b '5-6' )
    wpctl set-default $sink
    pkill -RTMIN+10 dwmblocks
end
