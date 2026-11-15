{ config, pkgs, lib, ... }:
let
  convertName = name: lib.toUpper (builtins.replaceStrings [ "-" ] [ "_" ] name);

  make = name: value:
    let
      executable = if lib.isDerivation value
        then lib.getExe value
        else value;
    in
      pkgs.writeShellScriptBin "hm-exec-${name}" "exec ${executable} $@";

  resolvedPackages = builtins.mapAttrs make config.mnm.definitions;
  resolvedPackagesUppercase = lib.mapAttrs' (name: value:
    lib.nameValuePair
      (convertName name)
      (lib.mkDefault (lib.getExe value))
  ) resolvedPackages;
in
{
  options.mnm = lib.mkOption {
    default = {};
    example = {};
    type = lib.types.submodule {
      options = {
        definitions = lib.mkOption {
          default = {};
          example = { applauncher = "${lib.getExe pkgs.rofi} -show drun"; };
          type = with lib.types; attrsOf (either str package);
        };
        packages = lib.mkOption {
          description = "packages corresponding to definitions above.";
          default = {};
          type = with lib.types; attrsOf package;
        };
      };
    };
  };

  config.home.sessionVariables = resolvedPackagesUppercase;
  config.mnm.packages = resolvedPackages;
  config.home.packages = builtins.attrValues resolvedPackages;
}
