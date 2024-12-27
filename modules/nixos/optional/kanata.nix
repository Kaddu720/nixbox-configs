{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    kanata.enable =
      lib.mkEnableOption "enables kanata";
  };

  config = lib.mkIf config.kanata.enable {
    hardware.uinput.enable = true;
    environment.systemPackages = [pkgs.kanata];

    services.kanata = {
      enable = true;
      keyboards = {
        linuxKeyboards = {
          devices = [
            "/dev/input/by-id/usb-Mode_SixtyFive_HA-event-kbd"
          ];
          extraDefCfg = "process-unmapped-keys yes";
          config = ''
            ;; defsrc is still necessary
            (defsrc
              lctl
            )

            (defvar
              tap-time 150
              hold-time 200
            )

            (defalias
              escctrl (tap-hold 100 100 esc lctl)
            )

            (deflayer base
              @escctrl
            )
          '';
        };
        frameworkKeyboard = {
          devices = [
            "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
          ];
          extraDefCfg = "process-unmapped-keys yes";
          config = ''
            ;; defsrc is still necessary
            (defsrc
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
              caps a    s    d    f    g    h    j    k    l    ;    '    ret
              lsft z    x    c    v    b    n    m    ,    .    /    rsft
              lctl lmet lalt           spc            ralt  rctl
            )

            (defvar
              tap-time 150
              hold-time 200
            )

            (defalias
              escctrl (tap-hold 100 100 esc lctl)
            )

            (deflayer base
              grv       1    2    3    4    5    6    7    8    9    0    -    =    \
              tab       q    w    e    r    t    y    u    i    o    p    [    ]    bspc
              @escctrl  a    s    d    f    g    h    j    k    l    ;    '    ret
              lsft      z    x    c    v    b    n    m    ,    .    /    rsft
              lctl lmet lalt           spc            ralt rctl
            )
          '';
        };
      };
    };
  };
}
