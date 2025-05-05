{ config, lib, ... }:

with lib;

let
  cfg = config.homeModules.programs.git;
in {
  options.homeModules.programs.git = {
    enable = mkEnableOption "Git";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "Sweetdogs";
      userEmail = "git@sweetdogs.ru";
    };
  };
} 