{ pkgs, lib, ... }:

{
  # Overrides.
  home-manager.users.yael = {
    services.batsignal.enable = true;
    services.polybar.script = lib.mkForce ''
    '';
    xsession.windowManager.bspwm.startupPrograms = [
      "${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --off --output DVI-D-1 --off --output DP-4 --mode 1920x1080 --pos 2560x0 --rotate normal --output DP-2 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DP-3 --off"
      "${pkgs.polybar}/bin/polybar leftbar"
      "${lib.getExe pkgs.feh} --no-fehbg --bg-scale $HOME/images/wallpaper.png"
      "${pkgs.polybar}/bin/polybar rightbar"
];
  };
}
