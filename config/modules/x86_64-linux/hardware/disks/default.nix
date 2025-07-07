{ config, lib, ... }:

with lib;

let
  cfg = config.modules.hardware.disks;
in {
  options.modules.hardware.disks = {
    enable = mkEnableOption "Support udisks2";
    
    gui = mkOption {
      type = types.bool;
      default = false;
      description = "Enable GNOME Disks";
    };
  };

  config = mkIf cfg.enable {
    services.udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
    
    programs.gnome-disks.enable = cfg.gui;
  };
} 