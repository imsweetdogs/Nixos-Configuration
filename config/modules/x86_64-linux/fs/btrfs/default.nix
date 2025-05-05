{ config, lib, ... }:

with lib;

let
  cfg = config.modules.fs.btrfs;
in {
  options.modules.fs.btrfs = {
    enable = mkEnableOption "Включение и настройка файловой системы btrfs";
    
    device = mkOption {
      type = types.str;
      default = "/dev/nvme0n1";
      description = "Путь к устройству для btrfs";
    };
    
    espSize = mkOption {
      type = types.str;
      default = "128M";
      example = "1G";
      description = "Размер ESP (EFI System Partition)";
    };
    
    swapSize = mkOption {
      type = types.str;
      default = "8G";
      example = "16G";
      description = "Размер раздела подкачки (swap)";
    };
    
    enableLUKS = mkOption {
      type = types.bool;
      default = false;
      description = "Включить LUKS шифрование для root раздела";
    };

    luksPassFile = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = "Файл с паролем для LUKS (null = запрос пароля при загрузке)";
    };

    subvolumes = mkOption {
      type = types.attrsOf (types.submodule {
        options = {
          mountpoint = mkOption {
            type = types.str;
            description = "Точка монтирования подтома";
          };
          options = mkOption {
            type = types.listOf types.str;
            default = [ "defaults" ];
            description = "Опции монтирования для подтома";
          };
        };
      });
      default = {
        "@" = { 
          mountpoint = "/";
          options = [ "defaults" "compress=zstd" ];
        };
        "@home" = {
          mountpoint = "/home";
          options = [ "defaults" "noatime" "compress=zstd:9" ];
        };
        "@nix" = {
          mountpoint = "/nix";
          options = [ "defaults" "noatime" "compress=zstd:7" ];
        };
      };
      description = "Подтома btrfs и их настройки";
    };
  };

  config = mkIf cfg.enable {
    # Переопределяем конфигурацию disko
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
            content = if cfg.enableLUKS then {
              type = "luks";
              name = "cryptroot";
              passwordFile = cfg.luksPassFile;
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = mapAttrs (name: subvol: {
                  mountpoint = subvol.mountpoint;
                  mountOptions = 
                    # Опции специфичные для подтома
                    subvol.options ++
                    # Указываем имя подтома
                    ["subvol=${name}"];
                }) cfg.subvolumes;
              };
            } else {
              type = "btrfs";
              extraArgs = ["-f"];
              subvolumes = mapAttrs (name: subvol: {
                mountpoint = subvol.mountpoint;
                mountOptions = 
                  # Опции специфичные для подтома
                  subvol.options ++
                  # Указываем имя подтома
                  ["subvol=${name}"];
              }) cfg.subvolumes;
            };
          };
        };
      };
    };
  };
} 