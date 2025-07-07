{ lib, config, ... }: 

with lib;

let
  cfg = config.modules.system.locales;
in {
  options = {
    modules.system.locales.enable = mkEnableOption "Enables locales";
  };

  config = mkIf cfg.enable {
    i18n = {
      defaultLocale = "en_US.UTF-8";
      supportedLocales = ["all"];
    };
  };
}