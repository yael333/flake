{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pavucontrol
    milkytracker
    rtmidi
  ];
}
