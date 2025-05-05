{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.homeModules.programs.rofi;
in {
  options.homeModules.programs.rofi = {
    enable = mkEnableOption "Enable rofi";
  };
  
  config = mkIf cfg.enable {
    programs.rofi.enable = true;
  };
}
