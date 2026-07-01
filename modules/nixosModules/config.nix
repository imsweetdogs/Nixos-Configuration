{ inputs, ... }: 

{
    flake.nixosModules.config = { lib, config, ... }: {
        options.myConfig = {
            targetDisk = lib.mkOption {
                type = lib.types.str;
                default = "/dev/sda";
                description = "Целевой диск для установки";
            };
            timeZone = lib.mkOption {
                type = lib.types.str;
                default = "Europe/Moscow";
                description = "Часовая зона";
            };
            stateVersion = lib.mkOption {
                type = lib.types.str;
                default = "26.05";
                description = "Версия NixOS";
            };
            activeUsers = lib.mkOption {
                type = lib.types.listOf lib.types.str;
                default = [ "sweetdogs" ];
                description = "Список обычных пользователей";
            };
            rootPassword = lib.mkOption {
                type = lib.types.str;
                default = "$6$sweetdogs$cyYAAMUOBqrnyW6mPaihX24NV0YH7YgZ9Y.69DiP9nphy4GyK4gM2RTmmXVs9dVPzdG7apAVRgOrE9ygSrOTX0";
                description = "Хеш пароля для root юзера";
            };
        };

        config = {
            nix.settings.experimental-features = [ "nix-command" "flakes" ];
            time.timeZone = config.myConfig.timeZone;
            system.stateVersion = config.myConfig.stateVersion;
        };
    };
}