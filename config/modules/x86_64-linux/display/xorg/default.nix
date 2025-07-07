{ config, lib, ... }:

with lib;

let
  cfg = config.modules.display.xorg;
in {
  options.modules.display.xorg = {
    enable = mkEnableOption "Support X11 server";
    
    videoDrivers = mkOption {
      type = types.listOf types.str;
      default = [];
      example = [ "amdgpu" "nvidia" "intel" ];
      description = "List for video drivers for enable in X11";
    };
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      videoDrivers = cfg.videoDrivers;
    };
  };
} 