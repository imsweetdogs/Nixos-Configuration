{ flake, ... }: {
  modules.services.earlyoom.enable = true;
  modules.services.zram.enable = true;
}