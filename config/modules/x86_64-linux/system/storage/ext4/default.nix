{ config, lib, ... }:

with lib;

let
  cfg = config.modules.system.storage.ext4;
in {
  options.modules.system.storage.ext4 = {
    enable = mkEnableOption "Enable ext4 boot disk layout (EFI, BIOS, swap, root)";
    device = mkOption {
      type = types.str;
      description = "Device to install ext4";
      example = "/dev/sda";
      default = "/dev/nvme0n1";
    };
    swapSize = mkOption {
      type = types.str;
      default = "8G";
      description = "Swap size";
    };
  };

  config = mkIf cfg.enable {
    disko.devices.disk.nixos = {
      device = cfg.device;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            name = "NIXBOOT";
            size = "1M";
            type = "EF02";
          };

          ESP = {
            name = "NIXESP";
            type = "EF00";
            size = "128M";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };

          swap = {
            name = "NIXSWAP";
            size = cfg.swapSize;
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };

          root = {
            name = "NIXROOT";
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}