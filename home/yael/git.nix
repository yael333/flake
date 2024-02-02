{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Yael";
    userEmail = "contact@yael.moe";
    ignores = [ "*.swp" "result" ];
    extraConfig = {
      # commit.gpgSign = true;
      # tag.gpgSign = true;
      # gpg.format = "ssh";
      # user.signingKey = "~/.ssh/id_ed25519_sk.pub";
      # push.autoSetupRemote = true;
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
