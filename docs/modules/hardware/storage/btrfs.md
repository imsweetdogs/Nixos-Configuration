# hardware.storage.btrfs

Модуль описывает схему разделов и точек монтирования **btrfs**-диска с помощью
[disko](https://github.com/nix-community/disko).

---

## Опции

| Опция | Тип | По умолчанию | Описание |
|-------|-----|--------------|----------|
| `modules.hardware.storage.btrfs.enable` | `bool` | `false` | Включает модуль. |
| `modules.hardware.storage.btrfs.device` | `str` | Передаётся параметром, если не указан, то `flake.conf.system.device` или `/dev/nvme0n1` | Диск/устройство для разметки. |
| `modules.hardware.storage.btrfs.swapSize` | `str` | `"8G"` | Размер раздела swap. |

---

## Макет разделов

| Раздел | Размер | Тип | Содержимое |
|--------|--------|-----|------------|
| `boot` | 1 MiB | `EF02` | BIOS-бут (grub MBR). |
| `ESP`  | 128 MiB | `EF00` | FAT32, монтируется в `/boot`. |
| `swap` | `swapSize` | swap | Файл подкачки, с поддержкой resume. |
| `root` | оставшееся | btrfs | Субтомы для `/`, `/nix`, `/home`, `/persist`.

У каждого субтома включается компрессия `zstd` и `noatime` (для `@home` сильнее
сжатие `zstd:7`, для `@persist` — `zstd:3`).

---

## Что делает модуль

При включении формирует дерево `disko.devices.disk.nixos` с описанным выше
содержанием. Disko затем создаёт разделы и файловые системы во время установки.

---

## Пример использования

```nix
modules.hardware.storage.btrfs = {
  enable = true;
  device = "/dev/sda";
  swapSize = "16G";
};
```

---

> Файл модуля: `config/modules/x86_64-linux/hardware/storage/btrfs/default.nix`

*Документация сформирована автоматически.* 