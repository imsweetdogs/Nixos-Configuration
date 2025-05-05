{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.programs.rofi;
in {
  options.modules.programs.rofi = {
    enable = mkEnableOption "Enable rofi";
  };
  
  config = mkIf cfg.enable {
    programs.rofi.enable = true;
  };
}
