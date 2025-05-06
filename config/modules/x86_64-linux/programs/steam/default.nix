{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.programs.steam;
in {
  options.modules.programs.steam = {
    enable = mkEnableOption "Steam support";
    
    package = mkOption {
      type = types.package;
      default = pkgs.unstable-unfree.steam;
      defaultText = literalExpression "pkgs.steam";
      description = "Steam package to use (support for port forwarding from overlays)";
    };
    
    hardware = mkOption {
      type = types.bool;
      default = true;
      description = "Enable support for Steam-compatible hardware";
    };
    
    protonGE = mkOption {
      type = types.bool;
      default = true;
      description = "Install Proton GE for improved Windows game compatibility";
    };
    
    protontricks = mkOption {
      type = types.bool;
      default = true;
      description = "Install Protontricks for fine-tuning Proton";
    };
    
    gamescope = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Gamescope session";
    };
    
    gamemode = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Gamemode for performance optimization during games";
    };
    
    networking = mkOption {
      type = types.submodule {
        options = {
          dedicatedServer = mkOption {
            type = types.bool;
            default = true;
            description = "Open ports for dedicated servers";
          };
          
          localNetworkGame = mkOption {
            type = types.bool;
            default = true;
            description = "Open ports for local network games";
          };
          
          remotePlay = mkOption {
            type = types.bool;
            default = true;
            description = "Open ports for Remote Play";
          };
        };
      };
      default = {};
      description = "Network settings for Steam";
    };
  };

  config = mkIf cfg.enable {    
    hardware.steam-hardware.enable = cfg.hardware;
    
    programs.steam = {
      enable = true;
      package = cfg.package;
      # Шрифт для поддержки различных языков
      fontPackages = with pkgs; [ source-han-sans ];
      
      # Настройки Proton
      protontricks.enable = cfg.protontricks;
      gamescopeSession.enable = cfg.gamescope;
      
      # Установка Proton GE
      extraCompatPackages = mkIf cfg.protonGE (with pkgs; [ proton-ge-bin ]);
      
      # Переадресация вызовов X11, улучшает UX
      extest.enable = true;
      
      # Настройки фаервола
      dedicatedServer.openFirewall = cfg.networking.dedicatedServer;
      localNetworkGameTransfers.openFirewall = cfg.networking.localNetworkGame;
      remotePlay.openFirewall = cfg.networking.remotePlay;
    };
    
    # Включение режима оптимизации для игр
    programs.gamemode.enable = cfg.gamemode;
  };
} 