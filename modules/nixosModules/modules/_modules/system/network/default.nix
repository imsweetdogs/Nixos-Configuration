{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkOption mkIf mkDefault types;
in {
    options.modules.system.network = {
        enable = mkEnableOption "Configures networking";

        hostname = mkOption {
            type = types.str;
            default = "nixos";
            description = "Hostname";
        };

        nameservers = mkOption {
            type = types.listOf types.str;
            default = [ "77.88.8.8" "77.88.8.1" ];
            description = "DNS nameservers";
        };
    };

    config = let
        cfg = config.modules.system.network;
    in mkIf cfg.enable {
        networking = {
            hostName = cfg.hostname;
            nameservers = cfg.nameservers;
            networkmanager = {
                enable = true;
                dns = "none";
            };
        };
    };
}
