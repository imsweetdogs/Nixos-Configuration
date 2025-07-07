{ flake, pkgs, ... }: {
  boot.kernelPackages = pkgs.master.linuxPackages_latest;
  powerManagement.cpuFreqGovernor = "performance";
  system.stateVersion = flake.conf.system.stateVersion; 
  time.timeZone = flake.conf.system.timeZone;

  modules.system.storage.btrfs.enable = true;
  modules.system.nix.enable = true;
  modules.system.boot = {
    enable = true;
    type = "grub";
  };
  modules.system.root.enable = true;
  modules.system.locales.enable = true;
  modules.system.env.enable = true;
  modules.system.shell.zsh.enable = true;
  modules.system.sysctl.enable = true;
}