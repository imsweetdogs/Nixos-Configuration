{ flake, pkgs, ... }: {
  modules.programs.adb.enable = true;
  modules.programs.steam = {
    enable = true;
    package = pkgs.master-unfree.steam;
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

  environment.systemPackages = with pkgs; [
    polkit_gnome
    appimage-run
    home-manager

    kitty
    firefox
    git
  ];
}