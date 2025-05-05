{ config, lib, ... }:

with lib;

let
  cfg = config.modules.hardware.pipewire;
in {
  options.modules.hardware.pipewire = {
    enable = mkEnableOption "Audio support via PipeWire";
    
    lowLatency = mkOption {
      type = types.bool;
      default = false;
      description = "Enable low latency settings for audio";
    };
    
    support32Bit = mkOption {
      type = types.bool;
      default = true;
      description = "Enable 32-bit support for ALSA";
    };
  };

  config = mkIf cfg.enable {
    security.rtkit.enable = true;
    
    services.pipewire = {
      enable = true;
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa = {
        enable = true;
        support32Bit = cfg.support32Bit;
      };
      
      # Настройки низкой задержки
      extraConfig.pipewire = mkIf cfg.lowLatency {
        "92-low-latency" = {
          context.properties = {
            default.clock.rate = 48000;
            default.clock.quantum = 32;
            default.clock.min-quantum = 32;
            default.clock.max-quantum = 32;
          };
        };
      };
    };
  };
} 