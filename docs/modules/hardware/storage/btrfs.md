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
| `modules.hardware.storage.btrfs.espSize` | `str` | `"128M"` | Размер EFI-раздела (ESP). |
| `modules.hardware.storage.btrfs.subvolumes` | `attrset` | см. ниже | Описание btrfs-субтомов; можно изменять/дополнять либо полностью заменить через `lib.mkForce`. |

---

## Макет разделов

| Раздел | Размер | Тип | Содержимое |
|--------|--------|-----|------------|
| `boot` | 1 MiB | `EF02` | BIOS-бут (grub MBR). |
| `ESP`  | `espSize` (по умолчанию 128 MiB) | `EF00` | FAT32, монтируется в `/boot`. |
| `swap` | `swapSize` | swap | Файл подкачки, с поддержкой resume. |
| `root` | оставшееся | btrfs | Субтомы для `/`, `/nix`, `/home`, `/persist`.

### Субтомы по умолчанию

```nix
# значение по умолчанию subvolumes
{
  "@root" = { mountpoint = "/";   mountOptions = [ "compress=zstd"   "noatime" ]; };
  "@nix"  = { mountpoint = "/nix"; mountOptions = [ "compress=zstd"   "noatime" ]; };
  "@home" = { mountpoint = "/home"; mountOptions = [ "compress=zstd:7" "noatime" ]; };
  "@persist" = { mountpoint = "/persist"; mountOptions = [ "compress=zstd:3" "noatime" ]; };
}
```

Вы можете:

• *Дополнить или переопределить отдельные поля*  — просто укажите нужные ключи.

```nix
modules.hardware.storage.btrfs.subvolumes."@root".mountOptions = [ "compress=zstd:19" "noatime" ];
```

• *Полностью заменить набор*  — используйте `lib.mkForce`:

```nix
{ lib, ... }: {
  modules.hardware.storage.btrfs.subvolumes = lib.mkForce {
    "@root" = { mountpoint = "/"; mountOptions = [ "compress=zstd" "noatime" ]; };
    "@srv"  = { mountpoint = "/srv"; mountOptions = [ "compress=zstd" "noatime" ]; };
  };
}
```

---

## Что делает модуль

При включении формирует дерево `disko.devices.disk.nixos` с описанным выше
содержанием. Disko затем создаёт разделы и файловые системы во время установки.

---

## Пример использования

```nix
modules.hardware.storage.btrfs = {
  enable   = true;
  device   = "/dev/sda";
  swapSize = "16G";
  espSize  = "256M";                # переопределяем размер EFI-раздела

  # дописываем новый субтом и изменяем опции существующего
  subvolumes = {
    "@root".mountOptions = [ "compress=zstd:19" "noatime" ];
    "@snapshots" = { mountpoint = "/.snapshots"; mountOptions = [ "compress=zstd" "noatime" ]; };
  };
};
```

---

> Файл модуля: `config/modules/x86_64-linux/hardware/storage/btrfs/default.nix`

*Документация сформирована автоматически.* 