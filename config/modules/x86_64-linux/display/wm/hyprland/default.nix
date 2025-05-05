{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.display.wm.hyprland;
in {
  options.modules.display.wm.hyprland = {
    enable = mkEnableOption "Hyprland support";
    
    xwayland = mkOption {
      type = types.bool;
      default = true;
      description = "Enable XWayland support for running X11 applications";
    };
    
    package = mkOption {
      type = types.nullOr types.package;
      default = null;
      description = "Hyprland package to use. If null, the default package will be used.";
    };
    
    portalPackage = mkOption {
      type = types.nullOr types.package;
      default = null;
      description = "xdg-desktop-portal-hyprland package to use. If null, the default package will be used.";
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