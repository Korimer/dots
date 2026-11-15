{ lib, pkgs, ... }:
{
  mnm.definitions.editor = "${lib.getExe pkgs.rofi} -show drun";
}
