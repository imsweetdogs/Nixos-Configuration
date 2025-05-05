{ config, lib, ... }:

with lib;

let
  cfg = config.modules.display.xorg;
in {
  options.modules.display.xorg = {
    enable = mkEnableOption "X.org server support";
    
    videoDrivers = mkOption {
      type = types.listOf types.str;
      default = [];
      example = [ "amdgpu" "nvidia" "intel" ];
      description = "List of video drivers to use";
    };
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      videoDrivers = cfg.videoDrivers;
    };
  };
} 