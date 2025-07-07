{ lib, flake, modulesPath, ... }: {
  imports = [
    "${flake.conf.path}/overlays/nixpkgs"
    (import "${flake.conf.path}/modules" { path = "${flake.conf.path}/modules/x86_64-linux"; lib = lib; })
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  modules.system.storage.btrfs.enable = true;

  modules.system.nix.enable = true;
  modules.system.boot = {
    enable = true;
    type = lib.mkDefault "grub";
  };
  modules.system.root.enable = true;
  modules.system.locales.enable = true;
  modules.network.nm.enable = true;

  system.stateVersion = flake.conf.system.stateVersion; 
  time.timeZone = flake.conf.system.timeZone;
}