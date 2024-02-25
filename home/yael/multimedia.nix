{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ffmpeg
    ffmpegthumbnailer
    feh
    gimp
    transmission
    xdg-utils
    xdg-user-dirs
    steam
    libreoffice-qt
  ];
}
