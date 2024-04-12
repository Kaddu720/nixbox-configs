# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
    ];

    boot.kernelModules = [ "kvm-amd" "amdgpu" ];

    # Enable openGL and vulkan for graphic
    hardware.opengl.enable = true;
    hardware.opengl.driSupport = true;
    hardware.opengl.driSupport32Bit = true;

    # mesa dirvers the wikis says to install
    hardware.opengl.extraPackages = [ pkgs.mesa.drivers pkgs.amdvlk ];
    hardware.opengl.extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];

    # Bootloader.
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;

    # Graphics Drivers
    boot.initrd.kernelModules = [ "amdgpu" ];

    networking.hostName = "Home-box"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "America/Los_Angeles";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    # enable experimental features and flakes
    nix.settings.experimental-features = [
        "nix-command" 
        "flakes"
    ];

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.noah = {
        isNormalUser = true;
        description = "Noah Wilson";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [];
    };


    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        git
        gnumake
        home-manager
        killall
        pixman
        python311Packages.pip
        wget
        wirelesstools
    ];
    # Configure Packages
    #enable  users to use packages
    services.locate.enable = true;

    #xserver
    services.xserver = {
        enable = true;
        displayManager.startx.enable = true;
        layout = "us";
        libinput.enable=true;
        xkbVariant = "";
      };

    #pipe wire
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    # Set fish as default shell
    programs.fish.enable = true;
    users.defaultUserShell = pkgs.fish;

    ##Environmental Variables##
    environment.variables = { 
        EDITOR = "nvim"; 
    };


    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.11"; # Did you read the comment?

    #automatic garbage collection
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };

}
