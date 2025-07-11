# hardware.storage.ext4

Модуль формирует разметку диска с корневым разделом **ext4** с использованием
[disko](https://github.com/nix-community/disko).

---

## Опции

| Опция | Тип | По умолчанию | Описание |
|-------|-----|--------------|----------|
| `modules.hardware.storage.ext4.enable` | `bool` | `false` | Включает модуль. |
| `modules.hardware.storage.ext4.device` | `str` | `flake.conf.system.device` или `/dev/nvme0n1` | Целевой диск. |
| `modules.hardware.storage.ext4.swapSize` | `str` | `"8G"` | Размер swap. |
| `modules.hardware.storage.ext4.espSize` | `str` | `"128M"` | Размер EFI-раздела (ESP). |

---

## Макет разделов

| Раздел | Размер | Тип | Содержимое |
|--------|--------|-----|------------|
| `boot` | 1 MiB | `EF02` | BIOS boot. |
| `ESP` | `espSize` (по умолчанию 128 MiB) | `EF00` | FAT32, монтируется в `/boot`. |
| `swap` | `swapSize` | swap | Раздел подкачки. |
| `root` | оставшееся | ext4 | Корневая файловая система `/`.

---

## Что делает модуль

При активации создаётся описание `disko.devices.disk.nixos` для указанного
устройства, после чего Disko автоматически разметит диск и отформатирует
разделы.

---

## Пример использования

```nix
modules.hardware.storage.ext4 = {
  enable   = true;
  device   = "/dev/vda";
  swapSize = "4G";
  espSize  = "256M";  # при необходимости переопределяем размер ESP
};
```

---

> Файл модуля: `config/modules/x86_64-linux/hardware/storage/ext4/default.nix`

*Документация сформирована автоматически.* 