{ pkgs, lib, ... }:

{
  # Overrides.
  home-manager.users.yael = {
    services.batsignal.enable = true;
    xsession.windowManager.i3.extraConfig = ''
      exec --no-startup-id ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --off --output DVI-D-1 --off --output DP-4 --mode 1920x1080 --pos 2560x0 --rotate normal --output DP-2 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DP-3 --off
      exec --no-startup-id ${lib.getExe pkgs.feh} --bg-scale $HOME/images/wallpaper.jpg
      '';
  };
}
