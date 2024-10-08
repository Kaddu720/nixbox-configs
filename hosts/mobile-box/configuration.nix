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

  networking.hostName = "Mobile-Box"; # Define your hostname.

  # Configure system specific packages
  environment = {
    systemPackages = with pkgs; [
      brightnessctl
      framework-tool
    ];
  };

  #Configure Services
  services = {
    # Enable framework firmware
    fwupd.enable = true;
  };

  # Imported Optional Modules
  kmonad.enable = true;
  auto-cpufreq.enable = true;

  # Enable automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  system.stateVersion = "23.11"; # Did you read the comment?
}
