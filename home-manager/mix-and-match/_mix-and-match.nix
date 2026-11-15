{ config, pkgs, lib, ... }:
let
  mnm = config.mnm.definitions;
  allDeclared = builtins.attrNames mnm;

  make = name:
    let
      value = mnm.${name};
      executable = if lib.isDerivation value
        then lib.getExe value
        else value;
    in
      lib.nameValuePair
        name
        (pkgs.writeShellScriptBin "hm-exec-${name}" "${executable} $@")
      ;

  resolvedPackages = builtins.listToAttrs (map make allDeclared);
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

  config.mnm.packages = resolvedPackages;
  config.home.packages = builtins.attrValues resolvedPackages;
}
