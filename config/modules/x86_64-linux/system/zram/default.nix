{ config, lib, ... }:

with lib;

let
  cfg = config.modules.system.zram;
in {
  options.modules.system.zram = {
    enable = mkEnableOption "ZRAM support";
    
    algorithm = mkOption {
      type = types.str;
      default = "zstd";
      description = "Compression algorithm for zram";
    };
    
    memoryPercent = mkOption {
      type = types.int;
      default = 100;
      description = "Percentage of RAM used for zram";
    };
    
    priority = mkOption {
      type = types.int;
      default = 1000;
      description = "Priority for zram usage (higher will be used first)";
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