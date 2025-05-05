{ config, flake, lib, ... }:

with lib;

let
  cfg = config.modules.system.root;
in {
  options.modules.system.root = {
    enable = mkEnableOption "Базовая настройка root пользователя";
  };

  config = mkIf cfg.enable {
    users.mutableUsers = false;
    users.users.root.hashedPassword = "$6$pokedim13$2HDvjLbVa6wItmJRywWvxO2dB2Wxopjvt3DY9CU3qMJc/8Ho6eoV8PWcUG/0M03avtMb1DYKQT63ZpYqPCUWL1";
  };
}