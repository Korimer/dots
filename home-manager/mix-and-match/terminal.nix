{ lib, pkgs, ... }:
{
  mnm.definitions.terminal = "${lib.getExe pkgs.kitty}";
}
