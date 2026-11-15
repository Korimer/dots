{ lib, pkgs, ... }:
{
  programs.fish.enable = true;
  mnm.definitions.shell = "${lib.getExe pkgs.fish}";
}
