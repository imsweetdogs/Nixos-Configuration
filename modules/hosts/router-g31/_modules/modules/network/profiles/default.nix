{ config, pkgs, self, ... }: {
    networking.networkmanager.ensureProfiles.profiles = {
        MTS = {
            connection = {
                id = "MTS";
                type = "gsm";
            };
            gsm = {
                apn = "internet.mts.ru";
                user = "mts";
                password = "mts";
                sim-operator-id = "25001";
            };
        };
        MegaFon = {
            connection = {
                id = "MegaFon";
                type = "gsm";
            };
            gsm = {
                apn = "internet";
                sim-operator-id = "25002";
            };
        };
    };
}