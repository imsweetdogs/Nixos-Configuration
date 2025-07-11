{ config, lib, ... }:

with lib;

let
  cfg = config.modules.network.nm;
in {
  options.modules.network.nm = {
    enable = mkEnableOption "Enable NetworkManager";
  };

  config = mkIf cfg.enable {
    networking.networkmanager.enable = true;
  };
}