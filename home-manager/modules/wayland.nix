{ pkgs, ... }:
{
  home.packages = [
    pkgs.wlr-randr
    pkgs.jq
  ];
}
