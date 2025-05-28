{
  lib,
  config,
  ...
}: {
  options = {
    aerospace.enable = lib.mkEnableOption "enables aerospace";
  };

  config = lib.mkIf config.aerospace.enable {
    home.file.".config/aerospace/aerospace.toml" = {
      text = /*toml*/ ''
        # AeroSpace Configuration v0.17.1
        # Documentation: https://nikitabobko.github.io/AeroSpace/

        # Startup configuration
        start-at-login = true
        after-login-command = [
          "exec-and-forget open -a 'Raycast'"
        ]

        # Layout configuration
        enable-normalization-flatten-containers = true
        enable-normalization-opposite-orientation-for-nested-containers = true
        accordion-padding = 0
        default-root-container-layout = 'tiles'
        default-root-container-orientation = 'auto'

        # Focus behavior
        on-focused-monitor-changed = ['move-mouse monitor-lazy-center']
        automatically-unhide-macos-hidden-apps = false

        # Keyboard configuration
        [key-mapping]
        preset = 'qwerty'

        # Window gaps configuration
        [gaps]
        inner.horizontal = 10
        inner.vertical = 10
        outer.left = 10
        outer.bottom = 10
        outer.top = 10
        outer.right = 10

        # Workspace definitions
        [workspace-to-monitor-force-assignment]
        dev = ['built-in', 'BenQ EX2710Q', 'VG27A']
        web = ['built-in', 'BenQ EX2710Q', 'VG27A']
        3 = ['built-in', 'BenQ EX2710Q', 'VG27A']
        com = ['built-in', 'BenQ GW2491', 'VG279QR']
        doc = ['built-in', 'BenQ GW2491', 'VG279QR']

        # Main binding mode
        [mode.main.binding]
        # Application launchers
        alt-enter = "exec-and-forget open -n -a 'ghostty'"
        alt-w = "exec-and-forget open -n -a 'Zen Browser'"
        alt-shift-q = 'close'
        
        # Toggle floating and fullscreen
        alt-t = 'layout floating tiling'
        alt-shift-f = 'fullscreen'
        
        # Reload config with easy access
        alt-shift-r = 'reload-config'

        # Focus navigation - vim-style
        alt-h = 'focus left'
        alt-j = 'focus down'
        alt-k = 'focus up'
        alt-l = 'focus right'

        # Window movement - vim-style with shift
        alt-shift-h = 'move left'
        alt-shift-j = 'move down'
        alt-shift-k = 'move up'
        alt-shift-l = 'move right'
        
        # Resize focused window - using correct syntax
        alt-ctrl-l = 'resize width -50'
        alt-ctrl-j = 'resize height +50'
        alt-ctrl-k = 'resize height -50'
        alt-ctrl-h = 'resize width +50'

        # Development workspace group (alt modifier)
        alt-1 = 'workspace dev'
        alt-2 = 'workspace web'
        alt-3 = 'workspace 3'
        alt-shift-1 = 'move-node-to-workspace dev'
        alt-shift-2 = 'move-node-to-workspace web'
        alt-shift-3 = 'move-node-to-workspace 3'
        alt-ctrl-1 = ['move-node-to-workspace dev', 'workspace dev']
        alt-ctrl-2 = ['move-node-to-workspace web', 'workspace web']
        alt-ctrl-3 = ['move-node-to-workspace 3', 'workspace 3']

        # Communication workspace group (cmd modifier)
        cmd-1 = 'workspace com'
        cmd-2 = 'workspace doc'
        cmd-shift-1 = 'move-node-to-workspace com'
        cmd-shift-2 = 'move-node-to-workspace doc'
        cmd-ctrl-1 = ['move-node-to-workspace com', 'workspace com']
        cmd-ctrl-2 = ['move-node-to-workspace doc', 'workspace doc']

        # Monitor movement
        alt-shift-period = 'move-node-to-monitor --wrap-around --focus-follows-window next'
        alt-shift-comma = 'move-node-to-monitor --wrap-around --focus-follows-window prev'
        
        # Quick layout switches with correct syntax
        alt-a = 'layout tiles'
        alt-s = 'layout accordion'
        
        # Switch orientation
        alt-backslash = 'layout horizontal vertical'

        # Utility mode access
        alt-shift-semicolon = 'mode service'

        # Service binding mode
        [mode.service.binding]
        esc = ['reload-config', 'mode main']
        backspace = ['close-all-windows-but-current', 'mode main']
        r = ['reload-config', 'mode main']
        q = ['mode main']

        # Application-specific rules - optimized for v0.17.1
        # We need separate rules for each action since arrays of commands in v0.17.1
        # are limited for on-window-detected

        # Terminal apps
        [[on-window-detected]]
        if.app-name-regex-substring = 'ghostty'
        run = "move-node-to-workspace dev"

        # Browser windows
        [[on-window-detected]]
        if.app-id = 'org.mozilla.com.zen.browser'
        run = "move-node-to-workspace web"
        
        # Floating apps
        [[on-window-detected]]
        if.app-id = 'com.cisco.anyconnect.gui'
        run = "layout floating"
        
        [[on-window-detected]]
        if.app-id = 'com.apple.systempreferences'
        run = "layout floating"
        
        [[on-window-detected]]
        if.app-id = 'com.apple.calculator'
        run = "layout floating"
        
        [[on-window-detected]]
        if.app-name-regex-substring = 'Raycast'
        run = "layout floating"

        # Communication apps
        [[on-window-detected]]
        if.app-id = 'com.tinyspeck.slackmacgap'
        run = "move-node-to-workspace com"

        [[on-window-detected]]
        if.app-id = 'com.microsoft.Outlook'
        run = "move-node-to-workspace com"

        # Meeting and document apps
        [[on-window-detected]]
        if.app-id = 'us.zoom.xos'
        run = "move-node-to-workspace doc"
        
        [[on-window-detected]]
        if.app-name-regex-substring = 'Preview'
        run = "move-node-to-workspace doc"
        
        [[on-window-detected]]
        if.app-name-regex-substring = 'Word'
        run = "move-node-to-workspace doc"
      '';
    };
  };
}
