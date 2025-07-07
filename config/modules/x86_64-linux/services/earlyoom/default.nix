{ config, lib, ... }:

with lib;

let
  cfg = config.modules.services.earlyoom;
in {
  options.modules.services.earlyoom = {
    enable = mkEnableOption "Earlyoom for secure with cpu leak";
  };

  config = mkIf cfg.enable {
    services.earlyoom.enable = true;
  };
} 