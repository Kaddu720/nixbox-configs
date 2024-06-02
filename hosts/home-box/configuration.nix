{ pkgs, inputs, ... }: {
    imports = [ # Include the results of the hardware scan.
        inputs.home-manager.nixosModules.default
        ./hardware-configuration.nix
        ../../modules/nixos/modules.nix
    ];

    # Set up Grub
    boot.loader = {
        efi.canTouchEfiVariables = true;
        grub = {
            enable = true;
            devices = [ "nodev" ];
            efiSupport = true;
            useOSProber = true;
        };
    };

    # decrypt encrypted partition
    boot.initrd.luks.devices = {
        root = {
        device = "/dev/nvme1n1p2";
        preLVM = true;
        };
    };

    # AMD Graphics Drivers
    boot.initrd.kernelModules = [ "amdgpu" ];

    # Enable openGl graphics
    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };

    networking.hostName = "Home-Box"; # Define your hostname.
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

    # Enable sound.
    sound.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.noah = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
        group = "users";
        createHome = true;
        home = "/home/noah";
        uid = 1000;
        shell = pkgs.fish;
        packages = with pkgs; [];
    };

    home-manager = {
        #also pas inputs to home-manager modules
        extraSpecialArgs = { inherit inputs; };
        users = {
            "noah" = import ../home-manager/home.nix;
        };
    };

    # Enable experimental packages
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Enable users to use programs
    services.locate.enable = true;

    #Enable Custom Nixos Modules
    xserver.enable = true;
    pipewire.enable = true;

    # List packages at system level
    environment.systemPackages = with pkgs; [
        dislocker
        git
        gnumake
        htop
        killall
        gcc13
        mangohud
        protonup
        python3
        python311Packages.pip
        neovim
        wget
        wirelesstools 
    ];

    # Enable Programs
    programs.fish.enable = true;
    programs.slock.enable = true;
    programs.steam.enable = true;
    programs.steam.gamescopeSession.enable = true;
    programs.gamemode.enable = true;
    services.mysql = {
        enable = true;
        package = pkgs.mariadb;
    };

    # Disable ssh ask pass
    programs.ssh.askPassword = "";

    # Environmental Variables##
    environment.variables = { 
        EDITOR = "nvim"; 
        HOME = "/home/noah";
    };

    environment.sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS =
            "/home/noah/.steam/root/compatibilityrools.d";
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

