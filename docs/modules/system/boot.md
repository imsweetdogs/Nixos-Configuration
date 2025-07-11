# system.boot

Модуль отвечает за настройку загрузчика системы. Поддерживаются два варианта:

* **GRUB** — классический загрузчик, подходит для большинства случаев.
* **systemd-boot** — более лёгкий загрузчик, удобен для UEFI-систем.

---

## Опции

| Опция | Тип | По умолчанию | Описание |
|-------|-----|--------------|----------|
| `modules.system.boot.enable` | `bool` | `false` | Включает модуль. При `false` остальные параметры игнорируются. |
| `modules.system.boot.type` | `"grub" \| "systemd-boot"` | `"grub"` | Какой загрузчик использовать. |
| `modules.system.boot.theme` | `path \| null` | `null` | Путь к теме оформления **GRUB**. |
| `modules.system.boot.splashImage` | `path \| null` | `null` | Фоновое изображение для **GRUB**. |

---

## Пример использования

```nix
{ pkgs, modules, ... }:

{
  modules.system.boot = {
    enable = true;
    type   = "grub";
    theme  = ./grub-theme;
    splashImage = ./grub-theme/background.png;
  };
}
```

Альтернативно для **systemd-boot**:

```nix
modules.system.boot = {
  enable = true;
  type   = "systemd-boot";
};
```

---

## Что делает модуль

* При `grub`:
  * Активирует `boot.loader.grub.enable`.
  * Включает поддержку EFI (`efiSupport = true`) и устанавливает загрузчик как съёмный (`efiInstallAsRemovable = true`).
  * Подключает `os-prober`.
  * Применяет указанные `theme` и `splashImage`, если они не `null`.
* При `systemd-boot`:
  * Активирует `boot.loader.systemd-boot.enable`.
  * Разрешает изменение EFI-переменных (`boot.loader.efi.canTouchEfiVariables = true`).

Все неназванные параметры наследуют стандартные значения NixOS.

---

> Файл модуля: `config/modules/x86_64-linux/system/boot/default.nix`

*Документация сформирована автоматически.*
