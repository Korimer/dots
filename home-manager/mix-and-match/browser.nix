{ inputs, config, lib, pkgs, ... }:
let
  zen = inputs.zen-browser;

  mkExtension = ex: {
    install_url = "https://addons.mozilla.org/firefox/downloads/latest/${ex}/latest.xpi";
    installation_mode = "force_installed";
    default_area = "navbar";
  };
in
{
  imports = [ zen.homeModules.default ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      ExtensionSettings = {
        "firefox@tampermonkey.net" = mkExtension "tampermonkey";
        "uBlock0@raymondhill.net" = mkExtension "ublock-origin";
        # Vimium
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = mkExtension "vimium-ff";
        # Bitwarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = mkExtension "bitwarden-password-manager";
      };
    };
  };

  mnm.definitions.browser = lib.getExe config.programs.zen-browser.package;
}
