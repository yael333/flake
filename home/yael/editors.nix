{ pkgs, inputs, ... }:

{
  programs.neovim = {
    enable = true;
  };

  home.file = {
     ".emacs.d" = {
         source = ./emacs.d;
         recursive = true;
     };
  };

  programs.emacs.enable = true;
  services.emacs = {
    enable = true;
    defaultEditor = true;
    startWithUserSession = true;
    client.enable = true;
  };
}
