{ config, lib, ... }:

with lib;

let
  cfg = config.modules.hardware.graphics;
in {
  options.modules.hardware.graphics = {
    enable = mkEnableOption "Graphics support";
    
    enable32Bit = mkOption {
      type = types.bool;
      default = true;
      description = "Enable 32 bit graphics support";
    };
  };

  config = mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = cfg.enable32Bit;
    };
  };
} 