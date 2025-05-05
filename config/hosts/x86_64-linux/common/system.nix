{ flake, lib, modulesPath, ... }: {
    imports = [
        "${flake.conf.structure.modules}/x86_64-linux"
        (modulesPath + "/installer/scan/not-detected.nix")
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    modules.fs.btrfs.enable = lib.mkDefault true;

    modules.system.boot = {
        enable = lib.mkDefault true;
        type = lib.mkDefault "grub";
    };

    modules.system.gc.enable = lib.mkDefault true;
    modules.system.network.enable = lib.mkDefault true;
    modules.system.root.enable = lib.mkDefault true;

    system.stateVersion = lib.mkDefault flake.conf.system.stateVersion; 
    time.timeZone = lib.mkDefault flake.conf.system.timeZone;
}