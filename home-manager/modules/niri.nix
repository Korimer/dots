{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.oniri.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
  home.file.".local/lib/niri/hm-conf.kdl".text = "";
}
