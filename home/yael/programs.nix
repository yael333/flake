{ pkgs, ... }:

{
  programs = {
    bat = {
      enable = true;
      config = {
        paging = "never";
        style = "numbers";
        theme = "catppuccin";
      };
    };

    zathura = {
      enable = true;
      options = {
        font = "JetBrains Mono 8";
        recolor = true;
      };
    };
  };
}
