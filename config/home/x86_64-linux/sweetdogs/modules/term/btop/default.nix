{ config, lib, ... }:

with lib;

let
  cfg = config.homeModules.term.btop;
in {
  options.homeModules.term.btop = {
    enable = mkEnableOption "Btop";
  };

  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;
    };
  };
} 