{ config, lib, ... }:

with lib;

let
  defaultSettings = {
    "vm.swappiness" = "10";
    "vm.vfs_cache_pressure" = "50";
    "net.core.netdev_max_backlog" = "100000";
    "net.core.somaxconn" = "100000";
    "net.ipv4.tcp_rmem" = "4096 87380 16777216";
    "net.ipv4.tcp_wmem" = "4096 65536 16777216";
  };

  cfg = config.modules.system.sysctl;
in {
  options.modules.system.sysctl = {
    enable = mkEnableOption "Optimized sysctl settings";

    extraSettings = mkOption {
      type = types.attrsOf types.str;
      default = {};
      description = "Additional or overriding sysctl parameters to merge with defaults.";
      example = {
        "net.ipv4.tcp_fin_timeout" = "15";
      };
    };
  };

  config = mkIf cfg.enable {
    boot.kernel.sysctl = mkMerge [ defaultSettings cfg.extraSettings ];
  };
} 