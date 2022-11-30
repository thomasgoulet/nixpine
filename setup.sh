#!/bin/sh
nix build --no-link ./nixpine#homeConfigurations.thomas.activationPackage
"$(nix path-info ./nixpine#homeConfigurations.thomas.activationPackage)"/activate
home-manager switch --flake './nixpine#thomas'