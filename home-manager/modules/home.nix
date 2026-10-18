{ config, pkgs, ... }:

{
  home.username = "korimer";
  home.homeDirectory = "/home/korimer";

  home.stateVersion = "26.05"; # Please read the comment before changing.

  home.packages = [
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
