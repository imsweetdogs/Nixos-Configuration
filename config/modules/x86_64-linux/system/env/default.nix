{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.system.env;
in {
  options.modules.system.env = {
    enable = mkEnableOption "Configures env";
  };

  config = mkIf cfg.enable {
    environment.sessionVariables = rec {
      XDG_BIN_HOME = "$HOME/.local/bin";
      PATH = [
        "${XDG_BIN_HOME}"
      ];
    };
  };
} 