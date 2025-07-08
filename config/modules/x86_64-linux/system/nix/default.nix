{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.system.nix;
in {
  options.modules.system.nix = {
    enable = mkEnableOption "Configure Nix and related services";

    experimentalFeatures = mkOption {
      type = types.listOf types.str;
      default = [ "nix-command" "flakes" ];
      description = "List of experimental Nix features to enable.";
    };

    gcAutomatic = mkOption {
      type = types.bool;
      default = true;
      description = "Whether Nix garbage collection should run automatically.";
    };

    gcDates = mkOption {
      type = types.str;
      default = "weekly";
      description = "Schedule for automatic Nix garbage collection.";
    };

    excludeXserverPackages = mkOption {
      type = types.listOf types.package;
      default = [ pkgs.xterm ];
      description = "Packages to remove from X server environment.";
    };

    excludeGnomePackages = mkOption {
      type = types.listOf types.package;
      default = [ pkgs.gnome-tour ];
      description = "Packages to remove from GNOME environment.";
    };

    enableDocumentation = mkOption {
      type = types.bool;
      default = false;
      description = "Enable full documentation (man, info, doc, nixos manuals).";
    };

    autoOptimiseStore = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable auto-optimise-store feature.";
    };

    substituters = mkOption {
      type = types.listOf types.str;
      default = [ "https://nixos-cache-proxy.sweetdogs.ru" ];
      description = "Additional binary cache substituter URLs.";
    };
  };

  config = mkIf cfg.enable {
    services.xserver.excludePackages = cfg.excludeXserverPackages;
    environment.gnome.excludePackages = cfg.excludeGnomePackages;

    documentation = {
      enable       = mkDefault cfg.enableDocumentation;
      doc.enable   = mkDefault cfg.enableDocumentation;
      info.enable  = mkDefault cfg.enableDocumentation;
      man.enable   = mkDefault cfg.enableDocumentation;
      nixos.enable = mkDefault cfg.enableDocumentation;
    };

    nix = {
      gc = {
        automatic = cfg.gcAutomatic;
        dates = cfg.gcDates;
      };
      settings = {
        experimental-features = cfg.experimentalFeatures;
        auto-optimise-store = cfg.autoOptimiseStore;
        substituters = cfg.substituters;
      };
    };
  };
}