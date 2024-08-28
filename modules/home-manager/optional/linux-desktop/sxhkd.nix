{ pkgs, lib, config, ... }: {
    options = {
        sxhkd.enable = 
            lib.mkEnableOption "enables sxhkd";
    };

    config = lib.mkIf config.sxhkd.enable {
        #services.sxhkd = {
        #    enable = true;
        #};

        home.packages = with pkgs; [ sxhkd ];
        home.file.".config/sxhkd/sxhkdrc" = {
            text = ''
                # Dk and sxhkd setting
                # ---------------------

                # reload sxhkd
                alt + shift + x
                    pkill -USR1 -x sxhkd

                # quit dk
                alt + shift + c
                    dkcmd exit

                # reload dkrc
                alt + shift + r
                    $HOME/.config/dk/dkrc

                # restart dk
                alt + ctrl + shift + r
                    dkcmd restart


                # Utilities
                # ---------------------

                # launcher
                alt + space
                    dmenu_run

                # terminal
                alt + Return
                    alacritty

                # browser
                alt + w
                    zen

                # screenshot and selection capture
                super + shift + s
                    flameshot gui


                # Hardware Control
                # ---------------------

                # dedicated volume keys
                {XF86AudioRaiseVolume,XF86AudioLowerVolume}
                    wpctl set-volume @DEFAULT_AUDIO_SINK@ {5%+,5%-} ; polybar-msg action pipewire hook 0

                # dedicated mute key
                {XF86AudioMute}
                    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ; polybar-msg action pipewire hook 0

                # dedicated backlight keys
                {XF86MonBrightnessUp,XF86MonBrightnessDown}
                    brightnessctl set {5%+,5%-}


                # Windows
                # ---------------------

                # focus next or previous window
                alt + {j,k}
                    dkcmd win focus {next,prev}

                # close window, swap tiled window in/out of master, cycle tiled windows in place
                alt + shift + {q,Return,Tab}
                    dkcmd win {kill,swap,cycle}

                # toggle fullscreen and fake fullscreen (enable manipulating fullscreen window)
                alt + {m,f}
                    dkcmd win {full,fakefull}

                # toggle floating, or sticky on a window
                alt + shift {f,s}
                    dkcmd win {float,stick}

                # toggle scratch pad
                alt + u
                    if ! pgrep -f "alacritty --class scratchpad" >/dev/null 2>&1; then alacritty --class scratchpad & else dkcmd win scratchpad scratch; fi

                # move window, signed (+/-) for relative changes, for tiled windows
                # y coord changes will move the window up/down the stack
                alt + shift + {h,j,k,l}
                    dkcmd win resize {x=-20,y=+20,y=-20,x=+20}

                # resize window, signed (+/-) for relative changes
                alt + ctrl + {h,j,k,l}
                    dkcmd win resize {w=-20,h=+20,h=-20,w=+20}

                # Work spaces
                # ---------------------

                # view, send, or follow to a workspace on monitor 1 (by number)
                alt + {_,shift + ,ctrl + }{1-6}
                    dkcmd ws {view,send,follow} {1-4}

                # view, send, or follow to a workspace on monitor 2 (by number)
                super + {_,shift + ,ctrl + }{1-2}
                    dkcmd ws {view,send,follow} {5-6}

                # view, send, or follow to the next, previous, or last active monitor
                alt + {_,shift + ,ctrl + }{comma,period,backslash}
                    dkcmd mon {view,send,follow} {prev,next,last}

                # change active workspace layout or cycle between them
                alt + {t,m,f,c}
                    dkcmd set layout {tile,mononone,none,cycle}

                # vim:ft=sxhkdrc
            '';
            executable = true;
        };
    };
}
