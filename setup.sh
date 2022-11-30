#!/bin/sh

nix build --no-link <flake-uri>#homeConfigurations.jdoe.activationPackage
"$(nix path-info <flake-uri>#homeConfigurations.jdoe.activationPackage)"/activate
home-manager switch --flake '<flake-uri>#jdoe'