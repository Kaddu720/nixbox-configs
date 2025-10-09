{pkgs, inputs, ...}: {
  # -------------------- Linux-specific Configuration --------------------
  
  # Session variables (home-manager native)
  home.sessionVariables = {
    TERMINAL = "ghostty";
    XDG_SESSION_TYPE = "wayland";
  };
  
  # Linux-specific packages (home-manager native)
  home.packages = with pkgs; [
    # Linux/Wayland System Tools
    kooha
    pavucontrol
    swaylock
    wl-clipboard
    grimblast
    river-classic
    # Flake inputs (Linux)
    inputs.zen-browser.packages."x86_64-linux".default
    inputs.ghostty.packages.x86_64-linux.default
  ];
  
  # Development tools (custom module option)
  dev-containers.enable = true;
  
  # Shell configuration (home-manager native)
  programs.bash.enable = true;
  
  # nh configuration (home-manager native)
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };
  
  # Services (home-manager native & custom module options)
  services = {
    desktop-config.linuxDesktop = true; # (custom module option)
    ssh-agent.enable = true; # (home-manager native)
  };
  
  # Wayland desktop entries (home-manager native)
  xdg.desktopEntries = {
    "discord-wayland" = {
      name = "Discord (Wayland)";
      comment = "Chat client with native Wayland support";
      exec = "${pkgs.discord}/bin/discord --enable-features=UseOzonePlatform --ozone-platform=wayland";
      icon = "discord";
      terminal = false;
      categories = ["Network" "InstantMessaging"];
    };
    "zoom-wayland" = {
      name = "Zoom (Wayland)";
      comment = "Video conferencing with Wayland support";
      exec = "${pkgs.zoom-us}/bin/zoom-us --enable-features=UseOzonePlatform --ozone-platform=wayland";
      icon = "zoom";
      terminal = false;
      categories = ["Network" "VideoConference"];
    };
  };
  
  # XDG configuration (home-manager native)
  xdg.mimeApps.defaultApplications = {
    "inode/directory" = "thunar";
  };
}
