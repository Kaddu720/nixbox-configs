{...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/common/users/root/nixos.nix
    ../../modules/common/users/noah/nixos.nix
    ../../modules/nixos/core
    ../../modules/nixos/optional
  ];

  networking.hostName = "Home-Box"; # Define your hostname.

  # Imported Optional Modules
  docker.enable = true;
  kanata.enable = true;
  games.enable = true;

  boot = {
    # Set up Grub
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        useOSProber = true;
      };
    };
    # decrypt encrypted partition
    initrd.luks.devices = {
      root = {
        device = "/dev/nvme1n1p2";
        preLVM = true;
      };
    };
    # Set up AMD Graphics Drivers
    initrd.kernelModules = ["amdgpu"];
  };

  hardware.uinput.enable = true;

  # Enable automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  system.stateVersion = "23.11"; # Did you read the comment?
}
