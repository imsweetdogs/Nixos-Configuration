{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.system.shell.zsh;
in {
  options.modules.system.shell.zsh = {
    enable = mkEnableOption "Configure Zsh shell";

    setAsDefaultShell = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to set Zsh as the default user shell.";
    };
  };

  config = mkIf cfg.enable {
    programs.zsh.enable = true;
    users.defaultUserShell = mkIf cfg.setAsDefaultShell pkgs.zsh;
  };
} 