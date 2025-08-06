{ inputs, flake, lib, modulesPath, pkgs, ... }: {
    imports = [
        (import "${flake.conf.path}/modules" { path = "${flake.conf.path}/modules/x86_64-linux"; lib = lib; })
        (import "${flake.conf.path}/modules" { path = "${./.}/modules"; lib = lib; })
        (modulesPath + "/installer/scan/not-detected.nix")
        flake.inputs.home-manager.nixosModules.home-manager
    ];

    # Desktop specific
    boot.kernelPackages = pkgs.linuxPackages_latest;
    powerManagement.cpuFreqGovernor = "performance";
    modules.system.env.enable = true;
    modules.system.nix.enable = true;
    modules.system.zram.enable = true;

    # Display modules
    modules.display.dm.sddm.enable = true;
    modules.display.wm.hyprland.enable = true;
    modules.display.xorg.enable = true;

    # Programs modules
    modules.programs.earlyoom.enable = true;
    modules.programs.steam = {
        enable = true;
        package = pkgs.unstable-unfree.steam;
    };
}