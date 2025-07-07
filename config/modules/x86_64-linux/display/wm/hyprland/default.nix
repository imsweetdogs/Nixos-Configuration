{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.display.wm.hyprland;
in {
  options.modules.display.wm.hyprland = {
    enable = mkEnableOption "Enable Hyprland (wayland) session";
    
    xwayland = mkOption {
      type = types.bool;
      default = true;
      description = "Enable XWayland for run X11 apps";
    };
    
    package = mkOption {
      type = types.nullOr types.package;
      default = null;
      description = "Hyprland package";
    };
    
    portalPackage = mkOption {
      type = types.nullOr types.package;
      default = null;
      description = "xdg-desktop-portal-hyprland package";
    };
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = cfg.xwayland;
      package = mkIf (cfg.package != null) cfg.package;
      portalPackage = mkIf (cfg.portalPackage != null) cfg.portalPackage;
    };
  };
} 