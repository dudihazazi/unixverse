{
  description = "my nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./default.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit zen-browser;
            };

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.dizzi21 = import ./home/dizzi21/home.nix;
          }
        ];
      };
    };
}
