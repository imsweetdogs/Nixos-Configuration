{ pkgs, inputs, flake,...}: {
    imports = [
        ../common/system.nix
    ];

    modules.fs.btrfs.device = "/dev/sdd";

    boot.kernelPackages = pkgs.linuxPackages_latest;
    nix.settings.auto-optimise-store = true;
    powerManagement.cpuFreqGovernor = "performance";

    modules.system.sysctl.enable = true;
    modules.system.shell.zsh.enable = true;
    modules.system.zram.enable = true;

    modules.hardware.bluetooth = {
        enable = true;
        gui = true;
    };
    modules.hardware.disks = {
        enable = true;
        gui = true;
    };
    modules.hardware.pipewire = {
        enable = true;
        lowLatency = true; 
    };
    modules.hardware.graphics.enable = true;
    modules.hardware.tablet.enable = true;

    modules.display.xorg = {
        enable = true;
        videoDrivers = [ "amdgpu" ];  
    };
    modules.display.wm.hyprland = {
        enable = true;
    };
    modules.display.dm.sddm.enable = true;

    modules.programs.adb.enable = true;
    modules.programs.earlyoom.enable = true;
    modules.programs.flatpak.enable = true;
    modules.programs.steam = {
        enable = true;
        package = pkgs.unstable-unfree.steam;
        hardware = true;
        protonGE = true;
        protontricks = true;
        gamescope = true;
        gamemode = true;
        networking = {
            dedicatedServer = true;
            localNetworkGame = true;
            remotePlay = true;
        };
    };

    nix.settings = {
        substituters = [
            "https://cache.garnix.io" 
            "https://hyprland.cachix.org"
            "https://nixos-cache-proxy.cofob.dev"
        ];
        trusted-public-keys = [
            "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
            "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        ];
    };

    home-manager = {
        useGlobalPkgs = true;
        extraSpecialArgs = { inherit inputs flake; };
        users = import "${flake.conf.structure.utils}/home.nix" { inherit inputs flake; arch = "x86_64-linux"; };
    };

    environment.systemPackages = with pkgs; [
        polkit_gnome
        appimage-run
    ];
}