{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.homeModules.programs.chromium;
in {
  options.homeModules.programs.chromium = {
    enable = mkEnableOption "Enable chromium";
  };
  
  config = mkIf cfg.enable {
    programs.chromium.enable = true;
  };
}
