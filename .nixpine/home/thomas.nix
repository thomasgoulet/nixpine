{ config, pkgs, ... }:

{

  programs.home-manager.enable = true;
  programs.nushell.enable = true;

  home = {

    stateVersion = "22.05";
    username = "thomas";
    homeDirectory = "/home/thomas";

    packages = with pkgs;
    [
      bat
      btop
      delta
      exa
      fd
      figlet
      fzf
      git
      gh
      grex
      helix
      less
      k9s
      kubectl
      lazygit
      lf
      neofetch
      neovim
      nushell
      podman
      ripgrep
      starship
      terraform
      terragrunt
      unzip
      vim
      zellij
      zoxide
    ];

    sessionVariables = {

      EDITOR = "hx";
      PAGER = "less -RF --no-init";
      
    };

  };

}