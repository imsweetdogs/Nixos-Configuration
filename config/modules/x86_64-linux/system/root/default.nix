{ config, flake, lib, ... }:

with lib;

let
  cfg = config.modules.system.root;
in {
  options.modules.system.root = {
    enable = mkEnableOption "Base root user settings";
  };

  config = mkIf cfg.enable {
    users.mutableUsers = false;
    users.users.root.hashedPassword = flake.conf.system.baseHashedPassword;
  };
}