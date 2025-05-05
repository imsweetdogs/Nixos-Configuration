{ config, lib, ... }:

with lib;

let
  cfg = config.modules.hardware.bluetooth;
in {
  options.modules.hardware.bluetooth = {
    enable = mkEnableOption "Bluetooth support";
    
    gui = mkOption {
      type = types.bool;
      default = false;
      description = "Enable the Blueman graphical interface for managing Bluetooth";
    };
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    
    services.blueman.enable = cfg.gui;
  };
} 