{ pkgs, inputs, ... }:

{
  programs.neovim = {
    enable = true;
  };
  home.sessionVariables.EDITOR = "nvim";
}
