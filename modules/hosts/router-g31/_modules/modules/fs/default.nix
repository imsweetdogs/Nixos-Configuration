{ config, ... }: {
    fileSystems."/" = {
        device = "tmpfs";
        fsType = "tmpfs";
        options = [ "size=25%" "mode=755" ];
    };

    # 128мб
    fileSystems."/boot" = {
        device = "/dev/disk/by-partlabel/router-boot";
        fsType = "ext4";
    };

    # 20гб (для нескольких поколений)
    fileSystems."/nix" = {
        device = "/dev/disk/by-partlabel/router-nix";
        fsType = "ext4";
        neededForBoot = true;
    };

    # 10гб
    fileSystems."/persistent" = {
        device = "/dev/disk/by-partlabel/router-persist";
        fsType = "ext4";
        neededForBoot = true;
    };

    # Всё оставшееся хранилище
    fileSystems."/storage" = {
        device = "/dev/disk/by-partlabel/router-storage";
        fsType = "ext4";
    };

    # 4гб, МММ вкусно когда swap на обычном старом hdd
    swapDevices = [{
        device = "/dev/disk/by-partlabel/router-swap";
    }];
}
