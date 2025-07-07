{ config, lib, ... }:

with lib;

let
  cfg = config.modules.services.zram;
in {
  options.modules.services.zram = {
    enable = mkEnableOption "Support for zram for virtual memory";
    
    algorithm = mkOption {
      type = types.str;
      default = "lz4";
      description = "Compression algorithm for zram (lz4 or zstd)";
    };
    
    memoryPercent = mkOption {
      type = types.int;
      default = 100;
      description = "Percentage of RAM used for zram";
    };
    
    priority = mkOption {
      type = types.int;
      default = 1000;
      description = "Priority of zram usage (higher will be used first)";
    };
  };

  config = mkIf cfg.enable {
    zramSwap = {
      enable = true;
      algorithm = cfg.algorithm;
      memoryPercent = cfg.memoryPercent;
      priority = cfg.priority;
    };
  };
} 