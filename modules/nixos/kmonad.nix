
{ lib, config,  ... }: {
    options = {
        kmonad.enable = 
            lib.mkEnableOption "enables kmonad";
    };

    config = lib.mkIf config.kmonad.enable {    
        services.kmonad = {
            enable = true;
            keyboards = {
                myKMonadOutput = {
                    device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
                    config = ''
                        ;; define laptop keybaord input
                        (defcfg
                            input  (device-file "/dev/input/by-id/usb-04d9_daskeyboard-event-kbd")
                            output (uinput-sink "My KMonad output"
                            "/run/current-system/sw/bin/sleep 1 && /run/current-system/sw/bin/setxkbmap -option compose:ralt")

                            fallthrough true
                        )

                        ;; define your keyboard
                        (defsrc
                          grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
                          tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
                          caps a    s    d    f    g    h    j    k    l    ;    '    ret
                          lsft z    x    c    v    b    n    m    ,    .    /    rsft
                          lctl lmet lalt           spc            ralt  rctl
                        )
                        
                        ;; alsiases for home row keys
                        (defalias
                            met_a (tap-hold-next-release 200 a lmet)
                            alt_s (tap-hold-next-release 200 s lalt)
                            sft_d (tap-hold-next-release 200 d lsft)
                            ctl_f (tap-hold-next-release 200 f lctl)

                            ctl_j (tap-hold-next-release 200 j rctl)
                            sft_k (tap-hold-next-release 200 k rsft)
                            alt_l (tap-hold-next-release 200 l lalt)
                            met_; (tap-hold-next-release 200 ; rmet)
                        )
                        
                        ;; translate aliases into output
                        (deflayer homerowmods
                            grv  1    2    3    4    5    6    7    8    9    0    -    =    \
                            tab  q    w    e    r    t    y    u    i    o    p    [    ]    bspc
                            lctl @met_a   @alt_s   @sft_d   @ctl_f   g   h   @ctl_j   @sft_k   @alt_l   @met_;    '    ret
                            lsft z    x    c    v    b    n    m    ,    .    /    rsft
                            lctl lmet lalt           spc            ralt rctl
                        )
                    '';
                };
            };
        };
    };
}
