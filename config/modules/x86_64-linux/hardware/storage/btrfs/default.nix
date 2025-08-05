{ config, lib, flake, ... }:

with lib;

let
  cfg = config.modules.hardware.storage.btrfs;
in {
  options.modules.hardware.storage.btrfs = {
    enable = mkEnableOption "Enable btrfs boot disk layout (EFI, BIOS, swap, root)";
    device = mkOption {
      type = types.str;
      description = "Device to install btrfs";
      example = "/dev/sda";
      default = flake.conf.system.device or "/dev/nvme0n1";
    };
    swapSize = mkOption {
      type = types.str;
      default = "8G";
      description = "Swap size";
    };

    espSize = mkOption {
      type = types.str;
      default = "128M";
      description = "EFI System Partition (ESP) size";
    };

    subvolumes = mkOption {
      type = types.attrs;
      default = {
        "@root" = {
          mountpoint = "/";
          mountOptions = [ "compress=zstd" "noatime" ];
        };
        "@nix" = {
          mountpoint = "/nix";
          mountOptions = [ "compress=zstd" "noatime" ];
        };
        "@home" = {
          mountpoint = "/home";
          mountOptions = [ "compress=zstd:7" "noatime" ];
        };
        "@persist" = {
          mountpoint = "/persist";
          mountOptions = [ "compress=zstd:3" "noatime" ];
        };
      };
      description = "Btrfs subvolume configuration attrset keyed by subvol name.";
      example = {
        "@root".mountOptions = [ "compress=zstd:15" "noatime" ];
        "@snapshots" = { mountpoint = "/.snapshots"; mountOptions = [ "compress=zstd" "noatime" ]; };
      };
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
            size = cfg.espSize;
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
              type = "btrfs";
              subvolumes = cfg.subvolumes;
            };
          };
        };
      };
    };
  };
}