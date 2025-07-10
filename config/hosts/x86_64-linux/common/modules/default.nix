{ inputs, flake, ... }: {
  modules.hardware.storage.btrfs.enable = true;

  modules.network.nm.enable = true;

  modules.system.boot.enable = true;
  modules.system.i18n.locales.enable = true;
  modules.system.i18n.timezone.enable = true;
  modules.system.root.enable = true;
  modules.system.shell.zsh.enable = true;
  modules.system.sysctl.enable = true;
}