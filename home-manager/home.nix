{ userConfig, ... }:
let
  username = userConfig.username;
in
{
  home.username = username;
  home.homeDirectory = "/home/${username}";

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
