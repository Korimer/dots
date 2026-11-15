{ lib, pkgs, ... }:
{
  mnm.definitions.launcher = "${lib.getExe pkgs.rofi} -show drun";
}
