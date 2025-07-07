{ config, lib, ... }:

with lib;

let
  cfg = config.modules.system.boot;
in {
  options.modules.system.boot = {
    enable = mkEnableOption "Configures boot loader";
    
    type = mkOption {
      type = types.enum [ "grub" "systemd-boot" ];
      default = "grub";
      description = "Type of boot loader to use";
    };
    
    theme = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = "Path to theme for GRUB";
    };
    
    splashImage = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = "Path to background image for GRUB";
    };
  };
  
  config = mkIf cfg.enable (mkMerge [
    (mkIf (cfg.type == "grub") {
      boot.loader.grub = {
        enable = true;
        efiSupport = mkDefault true;
        efiInstallAsRemovable = mkDefault true;
        useOSProber = mkDefault true;
        theme = mkIf (cfg.theme != null) cfg.theme;
        splashImage = mkIf (cfg.splashImage != null) cfg.splashImage;
      };
    })
    
    (mkIf (cfg.type == "systemd-boot") {
      boot.loader.systemd-boot = {
        enable = true;
        consoleMode = mkDefault "auto";
      };
      boot.loader.efi.canTouchEfiVariables = mkDefault true;
    })
  ]);
}