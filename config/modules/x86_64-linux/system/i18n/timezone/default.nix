{ lib, config, flake, ... }: 

with lib;

let
  cfg = config.modules.system.i18n.timezone;
in {
  options = {
    modules.system.i18n.timezone = {
      enable = mkEnableOption "Enable timezone configuration";

      timeZone = mkOption {
        type = types.str;
        default = flake.conf.system.timeZone or "UTC";
        description = "System time zone. Defaults to flake.conf.system.timeZone or \"UTC\".";
        example = "Europe/Moscow";
      };
    };
  };

  config = mkIf cfg.enable {
    time.timeZone = mkDefault cfg.timeZone;
  };
}