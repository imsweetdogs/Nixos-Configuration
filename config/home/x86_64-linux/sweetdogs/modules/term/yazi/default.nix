{ config, lib, ... }:

with lib;

let
  cfg = config.homeModules.term.yazi;
in {
  options.homeModules.term.yazi = {
    enable = mkEnableOption "Yazi";
  };

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
    };
  };
} 