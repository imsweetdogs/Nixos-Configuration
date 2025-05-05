{ flake, lib, ... }: {
  users.users.sweetdogs = {
    description = "Aleksey Baev";
    createHome = true;
    isNormalUser = true;
    hashedPassword = "$6$pokedim13$2HDvjLbVa6wItmJRywWvxO2dB2Wxopjvt3DY9CU3qMJc/8Ho6eoV8PWcUG/0M03avtMb1DYKQT63ZpYqPCUWL1";
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "video"
      "libvirtd"
      "adbusers"
    ];
  };
}