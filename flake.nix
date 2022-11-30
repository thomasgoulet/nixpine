{

  description = "Flake configuration for home-manager insisde WSL / Alpine";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
  
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  
  in {
    
    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
    
    home-manager-configuration = {
      thomas = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
        username = "thomas";
        homeDirectory = "/home/thomas";
        configuration.imports = [
          ./home.nix
        ];
      };
    };
    
  };

}