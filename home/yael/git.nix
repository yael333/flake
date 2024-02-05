{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Yael";
    userEmail = "git@yael.moe";
    ignores = [ "*.swp" "result" ];
    signing = {
      key = "31162B8161FBFCC47E870772C6BCF4314FC7F168";
      signByDefault = true;
    };
    extraConfig = {
      commit.gpgSign = true;
      tag.gpgSign = true;
      push.autoSetupRemote = true;
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      version = 1;
    };
  };

  home.packages = [ pkgs.git-open ];
}
