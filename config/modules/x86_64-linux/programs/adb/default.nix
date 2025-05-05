{ config, lib, ... }:

with lib;

let
  cfg = config.modules.programs.adb;
in {
  options.modules.programs.adb = {
    enable = mkEnableOption "Android Debug Bridge support";
  };

  config = mkIf cfg.enable {
    programs.adb.enable = true;
  };
} 