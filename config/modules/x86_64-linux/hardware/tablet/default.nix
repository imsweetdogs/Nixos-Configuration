{ config, lib, ... }:

with lib;

let
  cfg = config.modules.hardware.tablet;
in {
  options.modules.hardware.tablet = {
    enable = mkEnableOption "Настройка графического планшета";
  };

  config = mkIf cfg.enable {
    hardware.opentabletdriver.enable = true;
  };
} 