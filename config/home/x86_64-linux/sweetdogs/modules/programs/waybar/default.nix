{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.programs.waybar;
in {
  options.modules.programs.waybar = {
    enable = mkEnableOption "Enable waybar";
  };
  
  config = mkIf cfg.enable {
    programs.waybar.enable = true;
  };
}
