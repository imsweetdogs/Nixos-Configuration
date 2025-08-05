{ inputs, flake, lib, modulesPath, ... }: {
    imports = [
        (import "${flake.conf.path}/modules" { path = "${flake.conf.path}/modules/x86_64-linux"; lib = lib; })
        (modulesPath + "/installer/scan/not-detected.nix")
    ];

    # Base system reguired
    modules.hardware.storage.btrfs.enable = true;

    modules.network.nm.enable = true;

    modules.system.boot.enable = true;
    modules.system.i18n = {
        locales.enable = true;
        timezone.enable = true;
    };
    modules.system.root.enable = true;
    modules.system.shell.zsh.enable = true;
    modules.system.sysctl.enable = true;

    # Desktop specific
    boot.kernelPackages = pkgs.linuxPackages_latest;
    powerManagement.cpuFreqGovernor = "performance";
    modules.system.env.enable = true;
    modules.system.nix.enable = true;
    modules.system.zram.enable = true;

    # Hardware modules
    modules.hardware.graphics.enable = true;
    modules.hardware.bluetooth = {
        enable = true;
        gui = true;
    };
    modules.hardware.pipewire = {
        enable = true;
        lowLatency = true;
    };
    modules.hardware.disks = {
        enable = true;
        gui = true;
    };
    modules.hardware.tablet.enable = true;

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

    # Packages
    environment.systemPackages = with pkgs; [
        polkit_gnome
        appimage-run
        home-manager

        kitty
        firefox
        git
        pavucontrol
    ];
}