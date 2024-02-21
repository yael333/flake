{ pkgs, lib, config, ... }:

let
  isZshSetForUsers = lib.elem "zsh" (lib.mapAttrsToList (_: p: lib.getName p.shell) config.users.users);
in
{
  users.users.yael = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" ]
      ++ lib.optional config.virtualisation.libvirtd.enable "libvirtd"
      ++ lib.optional config.networking.networkmanager.enable "networkmanager"
      ++ lib.optional config.programs.light.enable "video"
      ++ lib.optional config.sound.enable "audio"
      ++ lib.optional config.programs.adb.enable "adbusers";
    shell = lib.mkIf config.services.xserver.enable pkgs.zsh; # I only care for ZSH on non-servers
    openssh.authorizedKeys.keys = [
    ];
  };

  # Needed to make completion available to home-manager.
  environment.pathsToLink = lib.optional isZshSetForUsers "/share/zsh";
  programs.zsh = {
    enable = isZshSetForUsers;
    enableGlobalCompInit = false;
  };
}
