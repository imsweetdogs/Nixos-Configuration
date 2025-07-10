{ inputs, flake, lib, modulesPath, ... }: {
  imports = [
    (import "${flake.conf.path}/modules" { path = "${flake.conf.path}/modules/x86_64-linux"; lib = lib; })
    (import "${flake.conf.path}/modules" { path = ./modules; lib = lib; })
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  modules.hardware.storage.btrfs.enable = true;

  modules.network.nm.enable = true;

  modules.system.boot.enable = true;
  modules.system.i18n.locales.enable = true;
  modules.system.i18n.timezone.enable = true;
  modules.system.root.enable = true;
  modules.system.shell.zsh.enable = true;
  modules.system.sysctl.enable = true;
}