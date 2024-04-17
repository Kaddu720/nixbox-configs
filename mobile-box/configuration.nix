# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ];

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # decrypt encrypted partition
    boot.initrd.luks.devices = {
        root = {
        device = "/dev/nvme0n1p2";
        preLVM = true;
        };
    };

    # Enable openGl graphics
    hardware.opengl.enable = true;

    networking.hostName = "Mobile-Box"; # Define your hostname.
    # Pick only one of the below networking options.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

    # Set your time zone.
    time.timeZone = "America/Los_Angeles";

    # Allow windows to have correct time on dual boot
    time.hardwareClockInLocalTime = true;

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    # console = {
    #   font = "Lat2-Terminus16";
    #   keyMap = "us";
    #   useXkbConfig = true; # use xkb.options in tty.
    # };

    # Enable CUPS to print documents.
    # services.printing.enable = true;

    # Enable sound.
    sound.enable = true;

    # Enable experimental packages
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.noah = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    group = "users";

    createHome = true;
    home = "/home/noah";
    uid = 1000;
    packages = with pkgs; [];
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        framework-tool
        git
        gnumake
        home-manager
        htop
        killall
        gcc13
        python3
        python311Packages.pip
        neovim
        wget
        wirelesstools 
    ];
    # Enable user to use programs
    services.locate.enable = true;

    # Enable the X11 windowing system.
    services.xserver = {
        enable = true;
        displayManager.startx.enable = true;
        libinput.enable = true;
    };

    # Disable ssh ask pass
    programs.ssh.askPassword = "";
    
    # Configure keymap in X11
    services.xserver.xkb.layout = "us";
    services.xserver.xkb.options = "eurosign:e,caps:escape";

    # Enable Pipe Wire
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
        wireplumber.enable = true;
    };

    # Set fish as default shell
    programs.fish.enable = true;
    users.defaultUserShell = pkgs.fish;   

    # Activate Slock
    programs.slock.enable = true;

    #mysql
    services.mysql = {
        enable = true;
        package = pkgs.mariadb;
    };

    # Environmental Variables##
    environment.variables = { 
        EDITOR = "nvim"; 
        HOME = "/home/noah";
    };


    # Copy the NixOS configuration file and link it from the resulting system
    # (/run/current-system/configuration.nix). This is useful in case you
    # accidentally delete configuration.nix.
    # system.copySystemConfiguration = true;

    # Enable automatic garbage collection
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };

    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
    #
    # Most users should NEVER change this value after the initial install, for any reason,
    # even if you've upgraded your system to a new NixOS release.
    #
    # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
    # so changing it will NOT upgrade your system.
    #
    # This value being lower than the current NixOS release does NOT mean your system is
    # out of date, out of support, or vulnerable.
    #
    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "23.11"; # Did you read the comment?
}

