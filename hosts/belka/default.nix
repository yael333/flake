{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./xserver.nix
    ./home
  ] ++ (with inputs.self.nixosModules; [
    profiles-android
    profiles-audio
    profiles-desktop
    profiles-opengl
    profiles-xserver
  ]);

  system.stateVersion = "23.11";
}
