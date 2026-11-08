{ config, ... }:
let
  devices = {
    netzach =
      "6YHTC4K-OJKAFYD-YNLFSLZ-FDLWDWD-SZ74KQP-ODTHEFP-JYUFRTO-4QWMYAP";
    vorkuta =
      "MH42F24-CWHFKLT-TBSM4X6-6PT5E4E-E6GK7FV-W7VG6CL-TD2HII7-DKAMQAL";
    fortnite =
      "PMUQNS6-YHEN3DN-VTHHF3R-HYEGNQE-GICN4I3-EB2OVOC-PS3OIPV-LNVYEAM";
    magic =
      "WQVGMX2-Z73AOXX-5GI4XFN-NUWYLKV-JX4TKBL-UFTORCG-AE2YAX6-KQYGQQU";
  };
  allDevices = builtins.attrNames devices;
in
{
  services.syncthing = {
    
    enable = true;
    overrideDevices = true;
    overrideFolders = true;

    settings.options = {
      urAccepted = 1; # allows syncthing to send usage data
      globalAnnounceServers = [ "https://funeralrubicon.duckdns.org:8443" ];
    };

    key = config.age.secrets."syncthing_key_${config.networking.hostName}".path;
    cert = config.age.secrets."syncthing_cert_${config.networking.hostName}".path;

    settings = {
      # awesome scoping win
      gui.user = "admin";
      guipasswordFile = config.age.secrets.syncthing_pw.path;

      devices = builtins.mapAttrs (_: value: { id = value; }) devices;

      folders = {
        "GlobalSync" = {
          path = "/etc/GlobalSync";
          devices = allDevices;
        };
        "NixSync" = {
          path = "/etc/nixos";
          devices = allDevices;
        };
      };
    };
  };
}

