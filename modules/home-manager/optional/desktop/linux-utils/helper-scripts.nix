{
  lib,
  config,
  ...
}: {
  options = {
    helper-scripts.enable =
      lib.mkEnableOption "config files for adhoc helper scripts";
  };

  config = lib.mkIf config.helper-scripts.enable {
    home.file = {
      ".config/scripts/rofi-menu.sh" = {
        executable = true;
        text =
          /*
          bash
          */
          ''
            #!/bin/sh

            # List scripts available
            command=$(ls .config/scripts | sed -e 's/\.sh$//' | rofi -dmenu -p)

            sh /home/noah/.config/scripts/$command.sh
          '';
      };
      ".config/scripts/lockscreen.sh" = {
        executable = true;
        text =
          /*
          bash
          */
          ''
            #!/bin/sh

            # Turn dunst back on when the script ends
            trap "dunstctl set-paused false" EXIT

            # pause notifications
            dunstctl set-paused true

            # enable the lock screen
            #slock
            swaylock --ignore-empty-password --color 000000 --no-unlock-indicator
          '';
      };
      ".config/scripts/audio-input.sh" = {
        executable = true;
        text =
          /*
          bash
          */
          ''
            #!/bin/sh

            # Create menu of audio syncs
            sink=$( wpctl status -k | grep -m 1 'Sinks:' --no-group-separator -A2 | grep -v 'Sinks' | cut -b 7-30 | rofi -dmenu -p "selct Audio Output" -l 2 | cut -b '5-6' )

            # Set new audio input
            wpctl set-default $sink
          '';
      };
      ".config/scripts/wifi.sh" = {
        executable = true;
        text =
          /*
          bash
          */
          ''
            #!/bin/sh

            # Create menu of wifi networks
            bssid=$(nmcli device wifi list | sed -n '1!p' | cut -b 9- | rofi -dmenu -p "Select wifi" -l 20  | cut -d ' ' -f1)

            # Enter usernamne
            name=$(echo "" 	| rofi -dmenu -p "Enter Username : ")

            # Enter password
            pass=$(echo "" 	| rofi -dmenu -p "Enter Password : ")

            nmcli device wifi connect $bssid name $name password $pass
          '';
      };
    };
  };
}
