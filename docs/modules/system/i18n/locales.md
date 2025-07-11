# system.i18n.locales

Модуль управляет генерацией и выбором системных локалей.

---

## Опции

| Опция | Тип | По умолчанию | Описание |
|-------|-----|--------------|----------|
| `modules.system.i18n.locales.enable` | `bool` | `false` | Включает модуль. |
| `modules.system.i18n.locales.defaultLocale` | `str` | `"en_US.UTF-8"` | Локаль, используемая по умолчанию системой. |
| `modules.system.i18n.locales.supportedLocales` | `list str` | `[ "all" ]` | Список локалей, которые будут сгенерированы (передаются в `supportedLocales`). |

---

## Что делает модуль

При `enable = true` он записывает значения в секцию `i18n`:

```nix
i18n = {
  defaultLocale    = cfg.defaultLocale;
  supportedLocales = cfg.supportedLocales;
};
```

---

## Пример использования

```nix
modules.system.i18n.locales = {
  enable = true;
  defaultLocale = "ru_RU.UTF-8";
  supportedLocales = [ "ru_RU.UTF-8" "en_US.UTF-8" ];
};
```

---

> Файл модуля: `config/modules/x86_64-linux/system/i18n/locales/default.nix`

*Документация сформирована автоматически.* 