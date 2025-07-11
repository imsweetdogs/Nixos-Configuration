# system.i18n.timezone

Модуль задаёт часовой пояс системы.

---

## Опции

| Опция | Тип | По умолчанию | Описание |
|-------|-----|--------------|----------|
| `modules.system.i18n.timezone.enable` | `bool` | `false` | Включает модуль. |
| `modules.system.i18n.timezone.timeZone` | `str` | `flake.conf.system.timeZone` или `"UTC"` | Часовой пояс в формате `Region/City`. |

---

## Что делает модуль

При `enable = true` добавляется конфигурация:

```nix
time.timeZone = cfg.timeZone;
```

Значение по умолчанию берётся из `flake.conf.system.timeZone` (если определено) или
становится `UTC`.

---

## Пример использования

```nix
modules.system.i18n.timezone = {
  enable = true;
  timeZone = "Europe/Moscow";
};
```

---

> Файл модуля: `config/modules/x86_64-linux/system/i18n/timezone/default.nix`

*Документация сформирована автоматически.* 