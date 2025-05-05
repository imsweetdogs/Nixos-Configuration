{ config, lib, ... }:

with lib;

let
  cfg = config.homeModules.term.fastfetch;
in {
  options.homeModules.term.fastfetch = {
    enable = mkEnableOption "Fastfetch";
  };

  config = mkIf cfg.enable {
    programs.fastfetch = {
      enable = true;
    };
  };
} 