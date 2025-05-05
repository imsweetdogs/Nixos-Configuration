{ config, lib, ... }:

with lib;

let
  cfg = config.homeModules.term.kitty;
in {
  options.homeModules.term.kitty = {
    enable = mkEnableOption "Kitty terminal";
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
    };
  };
} 