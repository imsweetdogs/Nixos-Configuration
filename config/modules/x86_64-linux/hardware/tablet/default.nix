{ config, lib, ... }:

with lib;

let
  cfg = config.modules.hardware.tablet;
in {
  options.modules.hardware.tablet = {
    enable = mkEnableOption "Enable OTD, for OSU! or Krita";
  };

  config = mkIf cfg.enable {
    hardware.opentabletdriver.enable = true;
  };
} 