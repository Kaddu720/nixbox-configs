{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    games.enable =
      lib.mkEnableOption "enables steam";
  };

  config = lib.mkIf config.games.enable {
    services.kanata = {
      enable = true;
      keyboards = {
        linuxKeyboards = {
          devices = [
          ];
          extraDefCfg = "process-unmapped-keys yes";
          config = ''
            ;; defsrc is still necessary
            (defsrc
              a s d f j k l ;
            )

            (defalias
              a (tap-hold $tap-time $hold-time a lmet)
              s (tap-hold $tap-time $hold-time s lalt)
              d (tap-hold $tap-time $hold-time d lsft)
              f (tap-hold $tap-time $hold-time f lctl)
              j (tap-hold $tap-time $hold-time j rctl)
              k (tap-hold $tap-time $hold-time k rsft)
              l (tap-hold $tap-time $hold-time l ralt)
              ; (tap-hold $tap-time $hold-time ; rmet)
            )

            (deflayer base
              @escctrl @a @s @d @f @j @k @l @;
            )
          '';
        };
      };
    };
  };
}
