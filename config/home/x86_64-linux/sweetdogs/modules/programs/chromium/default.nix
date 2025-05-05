{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.programs.chromium;
in {
  options.modules.programs.chromium = {
    enable = mkEnableOption "Enable chromium";
  };
  
  config = mkIf cfg.enable {
    programs.chromium.enable = true;
  };
}
