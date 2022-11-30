{ config, pkgs, ... }:

{

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;

  home.username = "thomas";
  home.homeDirectory = "/home/thomas";

  home.packages = [
    pkgs.bat
    pkgs.exa
    pkgs.fd
    pkgs.figlet
    pkgs.fzf
    pkgs.helix
    pkgs.jq
    pkgs.neofetch
    pkgs.neovim
    pkgs.ripgrep
    pkgs.unzip
    pkgs.vim
  ];

}