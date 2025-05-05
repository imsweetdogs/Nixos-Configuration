{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.homeModules.programs.firefox;
in {
  options.homeModules.programs.firefox = {
    enable = mkEnableOption "Enable firefox";
  };
  
  config = mkIf cfg.enable {
    programs.firefox.enable = true;
  };
}
