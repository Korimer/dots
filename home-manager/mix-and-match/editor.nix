{ lib, pkgs, ... }:
{
  #home.packages = with pkgs; [ neovide (lib.lowPrio neovim) ];
  #mnm.definitions.editor = "${lib.getExe pkgs.neovide}";
}
