{

  description = "Flake configuration for home-manager insisde WSL / Alpine";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { self, nixpkgs, flake-utils, home-manager, ... }:
    let

      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

    in
    rec
    {

      defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
      homeConfigurations.thomas = home-manager.lib.homeManagerConfiguration {

        inherit pkgs;

        modules = [
          ./home/thomas.nix
        ];

      };

    };

}