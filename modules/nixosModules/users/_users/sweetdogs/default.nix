{ config, pkgs, lib, ... }:
lib.mkIf (builtins.elem "sweetdogs" config.myConfig.activeUsers) {
    users.users.sweetdogs = {
        isNormalUser = true;
        description = "Main Administrator Account";
        hashedPassword = config.myConfig.rootPassword;
        createHome = true;
        extraGroups = [ "wheel" "networkmanager" "dialout" "modem" ];

        packages = with pkgs; [
            git
            fastfetch
        ];
    };
}
