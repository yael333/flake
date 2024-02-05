{ pkgs, inputs, ... }:

{
  programs.neovim = {
    enable = true;
  };
  home.sessionVariables.EDITOR = "nvim";
 

  home.file = {
     ".emacs.d" = {
         text = "hii";
         recursive = true;
     };
  };

  programs.emacs.enable = true;
  programs.emacs.extraPackages = (
     epkgs: (with epkgs; [
               better-defaults
               material-theme
               org
               org-bullets
               org-journal
               org-roam
               org-super-agenda        
               helm-org-rifle
               afternoon-theme
               workgroups2
               treemacs
               projectile
               slime
               yaml
               yaml-mode
               markdown-mode
               ox-pandoc
               use-package     
               notmuch   
            ])
   ); 
}
