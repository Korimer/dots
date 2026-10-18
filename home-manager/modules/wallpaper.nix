{ pkgs, lib, config, ... }:
{
  options.services.awww.defaultBackground = lib.mkOption {
    type = lib.types.nullOr lib.types.path;
    default = null;
    description = "Default background image to set when awww starts.";
  };

  config = {
    services.awww.enable = true;

    systemd.user.services.awww-default-background = lib.mkIf
      (config.services.awww.defaultBackground != null)
      {
        Unit = {
          After = [ "awww.service" ];
          Requires = [ "awww.service" ];
        };

        Service = {
          Type = "oneshot";
          ExecStart = "${pkgs.awww}/bin/awww img ${config.services.awww.defaultBackground}";
        };

        Install = {
          WantedBy = [ "default.target" ];
        };
      };
  };
}
