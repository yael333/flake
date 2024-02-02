{ inputs, ... }:

let
  commonProfiles = with inputs.self.nixosModules; [
    profiles-agenix
    profiles-docs
    profiles-misc
    profiles-nix-nixpkgs
    profiles-security
    profiles-ssh
    profiles-tailscale
    profiles-users
  ];

  commonHome = [
    inputs.home-manager.nixosModule
    {
      home-manager = {
        useGlobalPkgs = true;
        extraSpecialArgs = { inherit inputs; };
        users.yael = import ../home/yael;
      };
    }
  ];
  nixosSystemWithDefaults = args: (inputs.nixpkgs.lib.nixosSystem ((builtins.removeAttrs args [ "hostName" ]) // {
    specialArgs = { inherit inputs; } // args.specialArgs or { };
    modules = [
      ./${args.hostName}
      { networking = { inherit (args) hostName; }; }
    ] ++ commonProfiles ++ (args.modules or [ ]);
  }));
in

{
  flake.nixosConfigurations = {
    belka = nixosSystemWithDefaults {
      system = "x86_64-linux";
      hostName = "belka";
      modules = commonHome;
    };
  };
}
