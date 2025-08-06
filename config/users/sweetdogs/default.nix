{ flake, lib, ... }: {
  users.users.sweetdogs = {
    description = "Aleksey Baev";
    createHome = true;
    isNormalUser = true;
    hashedPassword = flake.conf.system.baseHashedPassword;
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "video"
    ];
  };
}