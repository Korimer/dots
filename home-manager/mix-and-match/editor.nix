{ lib, pkgs, ... }:
{
  mnm.definitions.editor = "${lib.getExe pkgs.nvim}";
}
