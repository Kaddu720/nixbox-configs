{...}: {
  # -------------------- Imports --------------------
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../users/root/nixos.nix
    ../../users/noah/nixos.nix
    ../../modules/nixos/core
    ../../modules/nixos/optional
  ];

  # -------------------- Networking --------------------
  networking = {
    hostName = "Home-Box"; # Define your hostname.
    # Enable network manager
    networkmanager.enable = true;
    # Optional: Configure firewall
    firewall = {
      enable = true;
      allowedTCPPorts = [22]; # SSH access
    };
  };

  # -------------------- Optional Modules --------------------
  docker.enable = true;
  kanata.enable = true;
  games.enable = true;

  # -------------------- Boot Configuration --------------------
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        useOSProber = true;
      };
    };

    initrd.luks.devices = {
      root = {
        device = "/dev/nvme1n1p2";
        preLVM = true;
        allowDiscards = true;
      };
    };

    initrd.kernelModules = ["amdgpu"];

    # Blacklist simpledrm in initrd so AMD becomes card0
    blacklistedKernelModules = ["simpledrm"];

    kernelParams = [
      "amd_pstate=active"
      "initcall_blacklist=simpledrm_platform_driver_init"
    ];
  };

  # -------------------- Hardware Configuration --------------------
  hardware = {
    uinput.enable = true;
    # Enable CPU microcode updates
    cpu.amd.updateMicrocode = true;

    # Graphics settings for steam
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  time = {
    hardwareClockInLocalTime = true;
  };

  # -------------------- Power Management --------------------
  # Enable power management features
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };

  # -------------------- System Maintenance --------------------
  # Enable automatic garbage collection
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # Optimize store
    settings = {
      auto-optimise-store = true;
    };

    # Nix memory optimization
    daemonCPUSchedPolicy = "batch";
    daemonIOSchedPriority = 7;
  };

  # -------------------- System Optimization --------------------
  # Enable zram swap
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  # -------------------- System Version --------------------
  # This option defines the first version of NixOS you have installed on this particular machine,
  system.stateVersion = "23.11"; # Did you read the comment?
}
