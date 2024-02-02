{
  nixConfig.extra-substituters = [ "https://yael.cachix.org" ];
  nixConfig.extra-trusted-public-keys = [ "yael.cachix.org-1:aZ9SqRdirTyygTRMfD95HMvIuzCoDcq2SmvNkaf9cnk=" ];

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    flake-parts = { url = "github:hercules-ci/flake-parts"; inputs.nixpkgs-lib.follows = "nixpkgs"; };
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    agenix = { url = "github:ryantm/agenix"; inputs.nixpkgs.follows = "nixpkgs"; };
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [
        ./hosts/flake-module.nix
        ./profiles/flake-module.nix
      ];
    };
}
