{pkgs, inputs, ...}: {
  # -------------------- Linux-specific Configuration --------------------
  
  home.sessionVariables = {
    TERMINAL = "ghostty";
    XDG_SESSION_TYPE = "wayland";
  };
  
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
  
  dev-containers.enable = true;
  
  programs.bash.enable = true;
  
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };
  
  services = {
    desktop-config.linuxDesktop = true;
    ssh-agent.enable = true;
  };
  
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
  
  xdg.mimeApps.defaultApplications = {
    "inode/directory" = "thunar";
  };
}
