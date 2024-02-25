{ pkgs, lib, ... }:

let 
  mod = "Mod4";
in
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
    windowManager.i3 = {
      enable = true;
      config = {
        modifier = mod;
        fonts = ["JetBrains Mono 12"];
        keybindings = lib.mkOptionDefault {
        "Mod1+1" = "exec librewolf";
        "Mod1+2" = "exec discord";
        "${mod}+Shift+s" = "exec ${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png";        

        # Focus
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        # Move
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";
        };
      };
    };
  };
}
