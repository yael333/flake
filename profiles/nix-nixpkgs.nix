{ inputs, ... }:
{ pkgs, lib, config, ... }:

{
   nix = {
     package = pkgs.nixUnstable;
    registry.nixpkgs.flake = inputs.nixpkgs;
    channel.enable = false;
    nixPath = lib.singleton config.nix.settings.nix-path;
     settings = {
       experimental-features = [
         "nix-command"
         "flakes"
         "cgroups"
         "auto-allocate-uids"
         "repl-flake"
       ];
      nix-path = "nixpkgs=flake:nixpkgs";
      use-cgroups = true;
      trusted-users = [
        "@wheel"
      ];
      allowed-users = lib.mapAttrsToList (_: u: u.name) (lib.filterAttrs (_: user: user.isNormalUser) config.users.users);
      http-connections = 0;
      max-substitution-jobs = 128;
     };

     gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 30d";
};
  };

  nixpkgs.config.allowUnfree = true;
}
