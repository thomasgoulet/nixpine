{
  
  description = "Flake for home-manager on Alpine / WSL";
  
  inputs = {
    
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.follows = "nixpkgs";
    
  };
  
  outputs = inputs: {
    
    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
    
    homeConfigurations = {
      "thomas" = inputs.home-manager.lib.homeManagerConfiguration {
        system = "x86_64";
        homeDirectory = "/home/thomas";
        username = "thomas";
        configuration.imports = [ ./home.nix ];
      };
    };
    
  };
  
}