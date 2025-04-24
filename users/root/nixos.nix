{
  pkgs,
  inputs,
  ...
}: {
  imports = [
  ];
  # -------------------- Networking --------------------
  networking.networkmanager.enable = true;

  # -------------------- Time Configuration --------------------
  time = {
    # Set your time zone.
    timeZone = "America/Los_Angeles";
    # Allow windows to have correct time on dual boot
    hardwareClockInLocalTime = true;
  };

  # -------------------- Internationalization --------------------
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # -------------------- Package Management --------------------
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # -------------------- Root User Configuration --------------------
  users.users.root = {
    shell = pkgs.bash; # Using bash for root shell
    initialPassword = ""; # Disable direct root login
  };

  # -------------------- Root Security --------------------
  security = {
    sudo = {
      enable = true;
      wheelNeedsPassword = true; # Require password for sudo

      # Optional: Configure sudo timeout (default is 5 minutes)
      extraConfig = ''
        Defaults timestamp_timeout=15
      '';
    };
  };

  # -------------------- SSH Configuration --------------------
  # Harden SSH settings
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  # -------------------- Environment Variables --------------------
  environment.sessionVariables = {
    # Flake location for nh
    FLAKE = "/home/noah/.config/nixos";
  };

  # -------------------- System Packages --------------------
  # Configure Environment
  environment = {
    # List packages at system level
    systemPackages = with pkgs; [
      dislocker
      killall
      neovim
      nh
      vlc
      wget
      # inputs.flox.packages.${pkgs.system}.default

      # Add useful admin tools
      htop # Better process viewer
      lsof # List open files
      pciutils # PCI utilities (lspci)
      usbutils # USB utilities (lsusb)
      smartmontools # Hard drive monitoring
      ripgrep # Better grep
      fd # Better find
    ];

    # Improve bash experience for root
    etc = {
      "skel/.bashrc".text = ''
        # Improved bash history
        export HISTCONTROL=ignoreboth:erasedups
        export HISTSIZE=10000
        export HISTFILESIZE=10000

        # Better prompt for root (red color for awareness)
        if [ "$UID" -eq 0 ]; then
          export PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
        fi

        # Useful aliases
        alias ls='ls --color=auto'
        alias ll='ls -la'
        alias grep='grep --color=auto'
        alias df='df -h'
        alias free='free -m'

        # Nix-specific aliases
        alias nrs='sudo nixos-rebuild switch'
        alias nrb='sudo nixos-rebuild boot'
        alias nrt='sudo nixos-rebuild test'
      '';
    };
  };

  # -------------------- System Services --------------------
  # enable bluetooth
  services.blueman.enable = true;
  # enable tailscale
  services.tailscale.enable = true;

  # -------------------- System Hardening --------------------
  # Clear /tmp on boot
  boot.tmp.cleanOnBoot = true;
}
