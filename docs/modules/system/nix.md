# system.nix

Модуль отвечает за настройку самого пакета **Nix**, его сервиса сборщика и связанных
опций: экспериментальные возможности, garbage collection, бинарные кэши и пр.

---

## Опции

| Опция | Тип | По умолчанию | Описание |
|-------|-----|--------------|----------|
| `modules.system.nix.enable` | `bool` | `false` | Активирует модуль. |
| `modules.system.nix.experimentalFeatures` | `list str` | `[ "nix-command" "flakes" ]` | Экспериментальные возможности Nix. |
| `modules.system.nix.gcAutomatic` | `bool` | `true` | Запускать автоматическую очистку (GC) магазина. |
| `modules.system.nix.gcDates` | `str` | `"weekly"` | Расписание GC (cron-формат или ключевые слова Nix). |
| `modules.system.nix.excludeXserverPackages` | `list package` | `[ pkgs.xterm ]` | Пакеты, исключаемые из X-серверного окружения. |
| `modules.system.nix.excludeGnomePackages` | `list package` | `[ pkgs.gnome-tour ]` | Пакеты, исключаемые из окружения GNOME. |
| `modules.system.nix.enableDocumentation` | `bool` | `false` | Устанавливать man/info/html-доки и мануалы NixOS. |
| `modules.system.nix.autoOptimiseStore` | `bool` | `true` | Автоматически оптимизировать (deduplicate) /nix/store. |
| `modules.system.nix.substituters` | `list str` | `[ "https://nixos-cache-proxy.sweetdogs.ru" ]` | Дополнительные бинарные кэши. |

---

## Что делает модуль

При включении модуль:

1. Исключает указанные пакеты из `services.xserver` и `environment.gnome`.
2. Настраивает секцию `documentation` (man, info, doc, nixos manuals) по флагу `enableDocumentation`.
3. Конфигурирует блок `nix`:
   * `gc.automatic` и `gc.dates` — для плановой очистки `/nix/store`.
   * `settings.experimental-features` — включает экспериментальные фичи.
   * `settings.auto-optimise-store` — дедупликация store.
   * `settings.substituters` — добавляет свои бинарные кэши.

---

## Пример использования

```nix
modules.system.nix = {
  enable = true;
  experimentalFeatures = [ "nix-command" "flakes" "recursive-nix" ];
  gcDates = "02:00";           # ежедневно в 2 часа ночи
  enableDocumentation = true;  # ставим все мануалы
  substituters = [
    "https://nixos-cache-proxy.sweetdogs.ru"
    "https://cache.nixos.org"
  ];
};
```

---

> Файл модуля: `config/modules/x86_64-linux/system/nix/default.nix`

*Документация сформирована автоматически.* 