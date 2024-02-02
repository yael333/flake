# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

    # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  boot.initrd.luks.devices."luks-fb8f5a57-4488-4c54-9a10-5dd8606c4c9f".device = "/dev/disk/by-uuid/fb8f5a57-4488-4c54-9a10-5dd8606c4c9f";
  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };


  boot.loader.grub.enableCryptodisk=true;

  boot.initrd.luks.devices."luks-a67be2fd-f7c1-4098-828c-5239cf2a3d0e".keyFile = "/crypto_keyfile.bin";
  boot.initrd.luks.devices."luks-fb8f5a57-4488-4c54-9a10-5dd8606c4c9f".keyFile = "/crypto_keyfile.bin";
  #networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.



  boot.initrd.availableKernelModules = [ "ata_piix" "mptspi" "uhci_hcd" "ehci_pci" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/060f8dcb-8599-4f21-af6f-b7ab47643056";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-a67be2fd-f7c1-4098-828c-5239cf2a3d0e".device = "/dev/disk/by-uuid/a67be2fd-f7c1-4098-828c-5239cf2a3d0e";

  swapDevices =
    [ { device = "/dev/disk/by-uuid/fe3b0855-6a44-4b51-80a3-2e11d1ab4d26"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.ens33.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
