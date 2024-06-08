{ lib, config, ... }: {
    options = {
        fish.enable = 
            lib.mkEnableOption "enables fish shell";
    };

    config = lib.mkIf config.fish.enable {    

        programs.fish = {
            enable = true;
            interactiveShellInit = ''
                set fish_greeting " Praise the Omnissiah"

                # bat color scheme
                set -gx BAT_THEME "base16"

                # Command to activate vi mode
                set -g fish_key_bindings fish_vi_key_bindings

                # Command to fix auto complete in vi mode
                bind -M insert \cf accept-autosuggestion

                #enable fzf, the fuck, and zoxide
                fzf --fish | source
                eval "$(thefuck --alias)"
                eval "$(zoxide init fish)"
                alias cd "z"

                # Fucntions
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
            '';
            shellAbbrs = {
                # Start Dashboard Development Server
                dashserv = "python manage.py runserver_plus --cert-file ~/Projects/mkcert/cert.pem --key-file ~/Projects/mkcert/key.pem";
            };
        };
        home.file = {
            ".config/fish/fish_variables".source = ./fish_variables;
        };
    };
}
