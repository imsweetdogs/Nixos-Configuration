{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkOption mkIf types;
in {
    options.modules.system.network.modemmanager = {
        enable = mkEnableOption "ModemManager";

        startfix = mkOption {
            type = types.bool;
            default = true;
            description = "Apply ModemManager systemd service fix (Restart=always)";
        };
    };

    config = mkIf (config.modules.system.network.enable && config.modules.system.network.modemmanager.enable) {
        networking.modemmanager.enable = true;

        systemd.services.ModemManager = mkIf config.modules.system.network.modemmanager.startfix {
            wantedBy = [ "multi-user.target" "network.target" ];
            serviceConfig = {
                Restart = "always";
                RestartSec = "3s";
                StartLimitIntervalSec = "0";
            };
        };
    };
}
