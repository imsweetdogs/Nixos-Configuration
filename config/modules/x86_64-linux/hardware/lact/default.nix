{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.hardware.lact;
in {
  options.modules.hardware.lact = {
    enable = mkEnableOption "Configures lact";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ lact ];
    systemd.packages = with pkgs; [ lact ];
    systemd.services.lactd.wantedBy = ["multi-user.target"];
  };
} 

