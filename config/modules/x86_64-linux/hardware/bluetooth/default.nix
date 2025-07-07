{ config, lib, ... }:

with lib;

let
  cfg = config.modules.hardware.bluetooth;
in {
  options.modules.hardware.bluetooth = {
    enable = mkEnableOption "Support Bluetooth";
    
    gui = mkOption {
      type = types.bool;
      default = false;
      description = "Enable gui Blueman for Bluetooth";
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