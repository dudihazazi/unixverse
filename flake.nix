{
  description = "my nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    oh-my-opencode-slim = {
      url = "github:alvinunreal/oh-my-opencode-slim";
      flake = false;
    };

    catppuccin = {
      url = "github:catppuccin/nix/release-26.05";
    };

  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgsUnstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        rog-laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs pkgsUnstable; };
          modules = [
            ./hosts/rog-laptop/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bak";
              home-manager.extraSpecialArgs = { inherit inputs pkgsUnstable; };
              home-manager.users.dizzi21 = import ./home/dizzi21/home-desktop.nix;
            }
          ];
        };
        wsl = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs pkgsUnstable; };
          modules = [
            inputs.nixos-wsl.nixosModules.default
            ./hosts/wsl/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bak";
              home-manager.extraSpecialArgs = { inherit inputs pkgsUnstable; };
              home-manager.users.dizzi21 = import ./home/dizzi21/home-wsl.nix;
            }
          ];
        };
      };
    };
}
