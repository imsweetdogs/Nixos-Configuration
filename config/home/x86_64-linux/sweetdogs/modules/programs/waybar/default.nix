{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.homeModules.programs.waybar;
in {
  options.homeModules.programs.waybar = {
    enable = mkEnableOption "Enable waybar";
  };
  
  config = mkIf cfg.enable {
    programs.waybar.enable = true;
  };
}
