{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
    ../../modules/common/users/root/nixos.nix
    ../../modules/common/users/noah/nixos.nix
    ../../modules/nixos/core
    ../../modules/nixos/optional
  ];

  networking.hostName = "Mobile-Box"; # Define your hostname.

  # Imported Optional Modules
  docker.enable = true;
  kanata.enable = true;

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

  # Configure system specific packages
  environment.systemPackages = with pkgs; [
    framework-tool
  ];

  # Configure system specific programs
  programs.auto-cpufreq = {
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

  #Configure Services
  services = {
    # Enable framework firmware
    fwupd.enable = true;
  };

  # Enable automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  system.stateVersion = "23.11"; # Did you read the comment?
}
