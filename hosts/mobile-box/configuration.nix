{ pkgs, inputs, ... }: {
    imports = [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ../../modules/common/users/root/nixos.nix
        ../../modules/common/users/noah/nixos.nix
        inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
    ];

    boot = {
        # Use the systemd-boot EFI boot loader.
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };

        # decrypt encrypted partition
        initrd.luks.devices = {
            root = {
            device = "/dev/nvme0n1p2";
            preLVM = true;
            };
        };
    };

    networking.hostName = "Mobile-Box"; # Define your hostname.

    #Configure environment Variables
    environment = {
        systemPackages = with pkgs; [
            brightnessctl
            framework-tool
        ];
    };

    #Configure Services
    services = {
        # Configure keyboard
        kmonad = {
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
                        
                        ;; translate aliases into output
                        (deflayer homerowmods
                            grv  1    2    3    4    5    6    7    8    9    0    -    =    \
                            tab  q    w    e    r    t    y    u    i    o    p    [    ]    bspc
                            lctl a    s    d    f    g    h    j    k    l    ;    '    ret
                            lsft z    x    c    v    b    n    m    ,    .    /    rsft
                            lctl lmet lalt           spc            ralt rctl
                        )
                    '';
                };
            };
        };
        # Enable framework firmware
        fwupd.enable = true;
    };

    # Configure Programs
    programs = {
        # Battery Power Controls
        auto-cpufreq = {
            enable = true;
            settings = {
                charger = {
                  governor = "performance";
                  turbo = "auto";
                };

                battery = {
                  governor = "powersave";
                  turbo = "auto";
                };
            };
        };
    };
}
