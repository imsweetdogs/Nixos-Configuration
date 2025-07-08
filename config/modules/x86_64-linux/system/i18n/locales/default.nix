{ lib, config, ... }: 

with lib;

let
  cfg = config.modules.system.i18n.locales;
in {
  options = {
    modules.system.i18n.locales = {
      enable = mkEnableOption "Enables locales";

      defaultLocale = mkOption {
        type = types.str;
        default = "en_US.UTF-8";
        description = "Default system locale.";
      };

      supportedLocales = mkOption {
        type = types.listOf types.str;
        default = ["all"];
        description = "List of locales that will be generated.'";
      };
    };
  };

  config = mkIf cfg.enable {
    i18n = {
      defaultLocale = cfg.defaultLocale;
      supportedLocales = cfg.supportedLocales;
    };
  };
}