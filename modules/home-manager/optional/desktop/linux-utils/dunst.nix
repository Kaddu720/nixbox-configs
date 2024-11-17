{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    dunst.enable =
      lib.mkEnableOption "enables dunst";
  };
  config = lib.mkIf config.dunst.enable {
    home.packages = with pkgs; [
      dunst
    ];

    home.file = {
      ".config/dunst/dunstrc".text = ''
        [global]
        monitor = 0
        follow = mouse
        width = 300
        height = 80
        origin = top-right
        offset = 20x60
        corner_radius = 0
        scale = 0
        notification_limit = 0
        progress_bar = true
        progress_bar_height = 80
        progress_bar_frame_width = 2
        progress_bar_min_width = 300
        progress_bar_max_width = 300
        indicate_hidden = yes
        transparency = 0
        separator_height = 2
        padding = 15
        horizontal_padding = 15
        text_icon_padding = 0
        frame_width = 2
        gap_size = 0
        separator_color = frame
        sort = yes
        idle_threshold = 120
        font = JetBrainsMono Nerd Font 10
        line_height = 2
        markup = full
        format = %s\n%b
        alignment = left
        vertical_alignment = center
        show_age_threshold = 60
        ellipsize = middle
        ignore_newline = no
        stack_duplicates = true
        hide_duplicate_count = false
        show_indicators = yes
        enable_recursive_icon_lookup = true
        icon_position = left
        min_icon_size = 24
        max_icon_size = 48
        sticky_history = yes
        history_length = 20
        browser = /usr/bin/xdg-open
        always_run_script = true
        mouse_left_click = close_current
        mouse_middle_click = do_action, close_current
        mouse_right_click = close_all
        title = Dunst
        class = Dunst

        [urgency_low]
        timeout = 5
        background = "#00000099"
        foreground = "#FFFFFFFF"
        frame_color = "#DD9998FF"

        [urgency_normal]
        timeout = 5
        background = "#00000099"
        foreground = "#FFFFFFFF"
        frame_color = "#DD9998FF"

        [urgency_critical]
        timeout = 5
        background = "#00000099"
        foreground = "#FFFFFFFF"
        frame_color = "#DD9998FF"
      '';
    };
  };
}
