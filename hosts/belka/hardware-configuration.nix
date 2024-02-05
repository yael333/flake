# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  
  networking.networkmanager.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-19131234-41a0-43db-ae7f-e02f698dcbbc".device = "/dev/disk/by-uuid/19131234-41a0-43db-ae7f-e02f698dcbbc";

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/22c93736-ee64-48be-b6e4-3d09050fce1f";
      fsType = "ext4";
    };

  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/4C4238AB42389BA0";
    fsType = "ntfs-3g";
    options = [ "rw" "uid=1000" ];
  };

  boot.initrd.luks.devices."luks-406f9f9d-d089-4589-bfda-1a720aa36273".device = "/dev/disk/by-uuid/406f9f9d-d089-4589-bfda-1a720aa36273";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/D853-5589";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/a21486f6-a7de-4f62-bebf-9af1c5aa9fb3"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;

  #nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
