{ lib, pkgs, ... }:
{
  services.flameshot.enable = true;
  mnm.definitions.localscreenshot = "${lib.getExe pkgs.flameshot} gui";
  mnm.definitions.globalscreenshot = "${lib.getExe pkgs.flameshot} screen";
  mnm.definitions.fullscreenshot = "${lib.getExe pkgs.flameshot} full";
}
