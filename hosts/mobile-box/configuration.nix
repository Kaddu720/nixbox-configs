{ pkgs, inputs, ... }: {
    imports = [ # Include the results of the hardware scan.
        inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
        ./hardware-configuration.nix
        ../../modules/nixos/modules.nix
        ../../modules/nixos/laptop-modules.nix
    ];

    boot = {
        # Use the systemd-boot EFI boot loader.
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };

        # decrypt encrypted partition
        initrd.luks.devices = {
            root = {
            device = "/dev/nvme0n1p2";
            preLVM = true;
            };
        };
    };

    # Enable openGl graphics
    hardware.opengl.enable = true;

    networking.hostName = "Mobile-Box"; # Define your hostname.
    # Pick only one of the below networking options.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

    # Set your time zone.
    time = {
        timeZone = "America/Los_Angeles";
        # Allow windows to have correct time on dual boot
        hardwareClockInLocalTime = true;
    };


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

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.noah = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
        group = "users";
        createHome = true;
        home = "/home/noah";
        uid = 1000;
    };

    # Enable experimental packages
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    #Configure environment Variables
    environment = {
        systemPackages = with pkgs; [
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
        # Environmental Variables##
        variables = { 
            EDITOR = "nvim"; 
            HOME = "/home/noah";
        };
    };

    #Configure Services
    services = {
        # Enable framework firmware
        fwupd.enable = true;

        # Enable users to use programs
        locate.enable = true;

        mysql = {
            enable = true;
            package = pkgs.mariadb;
        };
    };

    # Configure Programs
    programs = {
        slock.enable = true;

        # Enable gtk desktop
        dconf.enable = true;
       

        ssh = {
            startAgent = true;
            askPassword = "";
        };

        # Battery Power Controls
        auto-cpufreq = {
            enable = true;
            settings = {
                charger = {
                  governor = "performance";
                  turbo = "auto";
                };

                battery = {
                  governor = "powersave";
                  turbo = "auto";
                };
            };
        };
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
