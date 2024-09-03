{...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/common/users/root/nixos.nix
    ../../modules/common/users/noah/nixos.nix
    ../../modules/nixos/core
    ../../modules/nixos/optional
  ];

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

  networking.hostName = "Home-Box"; # Define your hostname.

  # Imported Optional Modules
  steam.enable = true;
}
