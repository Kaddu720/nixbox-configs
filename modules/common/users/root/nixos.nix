{pkgs, ...}: {
  imports = [
  ];

  networking.networkmanager.enable = true;

  time = {
    # Set your time zone.
    timeZone = "America/Los_Angeles";

    # Allow windows to have correct time on dual boot
    hardwareClockInLocalTime = true;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable experimental packages
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Configure Environment
  environment = {
    # List packages at system level
    systemPackages = with pkgs; [
      dislocker
      killall
      mangohud
      neovim
      nh
      vlc
      wget
    ];
  };

  # enable bluetooth
  services.blueman.enable = true;
  # enable tailscale
  services.tailscale.enable = true;
}
