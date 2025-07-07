{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.system.nix;
in {
  options.modules.system.nix = {
    enable = mkEnableOption "Configurating nixpkgs";
  };

  config = mkIf cfg.enable {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nix.gc = {
      automatic = true;
      dates = "weekly";
    };

    services.xserver.excludePackages = [ pkgs.xterm ];
    environment.gnome.excludePackages = [ pkgs.gnome-tour ];

    documentation = {
      enable = mkDefault false;
      doc.enable = mkDefault false;
      info.enable = mkDefault false;
      man.enable = mkDefault false;
      nixos.enable = mkDefault false;
    };

    nix.settings.auto-optimise-store = true;

    nix.settings = {
      substituters = [
        "https://nixos-cache-proxy.sweetdogs.ru"
      ];
    };
  };
}