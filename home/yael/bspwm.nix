{ pkgs, lib, ... }:

{
  # home.pointerCursor = {
  #   package = pkgs.gnome.adwaita-icon-theme;
  #   name = "Adwaita";
  #   size = 24;
  #   x11.enable = true;
  #   gtk.enable = true;
  # };

  xsession = {
    enable = true;
    windowManager.bspwm = {
      enable = true;
      monitors = {
        DP-2 = [ "1" "3" "5" "7" "9" ];
	DP-4 = [ "2" "4" "6" "8" "10" ];
      };
      settings = {
        #remove_disabled_monitors = true;
        #remove_unplugged_monitors = true;
        normal_border_color = "#6E738D";
        focused_border_color = "#f5bde6"; # catppuccin macchiato
        border_width = 2;
        window_gap = 2;
      };
      rules."Zathura".state = "tiled";
    };
  };
}
