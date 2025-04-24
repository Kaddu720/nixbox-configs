{
  pkgs,
  inputs,
  ...
}: {
  # -------------------- Imports --------------------
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
    ../../users/root/nixos.nix
    ../../users/noah/nixos.nix
    ../../modules/nixos/core
    ../../modules/nixos/optional
  ];

  # -------------------- Networking --------------------
  networking = {
    hostName = "Mobile-Box"; # Define your hostname.
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

  # -------------------- Boot Configuration --------------------
  boot = {
    # Use the systemd-boot EFI boot loader.
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10; # Limit old configurations kept
        editor = false; # Disable boot parameter editing for security
      };
      efi.canTouchEfiVariables = true;
    };

    # decrypt encrypted partition
    initrd.luks.devices = {
      root = {
        device = "/dev/nvme0n1p2";
        preLVM = true;
        allowDiscards = true; # Enable TRIM for SSDs
      };
    };

    # Turn off USB auto suspend
    # bellow that
    # HDMI audio set up
    extraModprobeConfig = ''
      options usbcore autosuspend=-1
      options snd-hda-intel model=auto probe_mask=1 enable_msi=1
      options snd-hda-codec-hdmi patch=1
    '';

    # Kernel optimization for Intel CPUs and laptops
    kernelParams = [
      "intel_pstate=active" # Better Intel CPU power management
      "mem_sleep_default=deep" # Better power savings during sleep
      "nvme.noacpi=1" # Fix for some NVMe drive issues
      "usbcore.autosuspend=-1" #support external usb devices
    ];

    # Optimize kernel for laptops
    kernel.sysctl = {
      "vm.laptop_mode" = 5;
      "vm.swappiness" = 10; # Reduce swapping to disk
    };
  };

  # -------------------- Hardware Configuration --------------------
  hardware = {
    # Enable CPU microcode updates
    cpu.intel.updateMicrocode = true;

    # Bluetooth support
    bluetooth = {
      enable = true;
      powerOnBoot = false; # Save power by disabling on boot
    };
  };

  # Settings to support usb performance
  services.udev.extraRules = ''
    # Disable autosuspend for USB input devices (mice, keyboards, etc.)
    ACTION=="add", SUBSYSTEM=="usb", ATTR{bInterfaceClass}=="03", ATTR{power/autosuspend}="-1"
    ACTION=="add", SUBSYSTEM=="usb", ATTR{bInterfaceClass}=="03", ATTR{power/control}="on"
  '';

  # -------------------- Power Management --------------------
  powerManagement = {
    enable = true;
    powertop.enable = true; # Enable powertop for power diagnostics
  };

  # -------------------- System Packages --------------------
  # Configure system specific packages
  environment.systemPackages = with pkgs; [
    framework-tool
    powertop
    intel-gpu-tools
    thermald # Thermal management daemon
    tlp # Additional power management
  ];

  # -------------------- Program Configuration --------------------
  # Configure system specific programs
  programs = {
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

    # Light for backlight control
    light.enable = true;
  };

  # -------------------- System Services --------------------
  # Configure Services
  services = {
    # Enable framework firmware
    fwupd.enable = true;

    # Thermal optimization
    thermald.enable = true;

    # TLP for power management
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        # PCIe power management
        PCIE_ASPM_ON_AC = "default";
        PCIE_ASPM_ON_BAT = "powersupersave";

        # Runtime PM for PCIe devices
        RUNTIME_PM_ON_AC = "on";
        RUNTIME_PM_ON_BAT = "auto";

        # Battery optimization
        START_CHARGE_THRESH_BAT0 = 75; # Start charging at 75%
        STOP_CHARGE_THRESH_BAT0 = 80; # Stop charging at 80%

        # Disable USB autosuspend
        USB_AUTOSUSPEND = 0;
      };
    };

    # Better touchpad support
    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        naturalScrolling = true;
        accelProfile = "adaptive";
      };
    };
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
