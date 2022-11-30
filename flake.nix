{

  description = "Flake configuration for home-manager insisde WSL / Alpine";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
  let
  
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  
  in {
    
    home-manager-configuration = {
      thomas = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        
        modules = [
          ./home.nix
        ];
        
      };
    };
    
  };

}