{ config, lib, ... }:

with lib;

let
  cfg = config.modules.display.dm.sddm;
in {
  options.modules.display.dm.sddm = {
    enable = mkEnableOption "Enable SDDM";
    
    theme = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Custom theme SDDM";
    };
  };

  config = mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;
      theme = mkIf (cfg.theme != null) cfg.theme;
    };
  };
} 