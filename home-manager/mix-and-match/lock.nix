{ lib, pkgs, ... }:
{
  mnm.definitions.lock-session = "${lib.getExe' pkgs.systemd "loginctl"} lock-session";
}
