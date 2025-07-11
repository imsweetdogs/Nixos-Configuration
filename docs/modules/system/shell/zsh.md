# system.shell.zsh

Модуль включает поддержку оболочки **Z Shell** (Zsh) на уровне системы.

---

## Опции

| Опция | Тип | По умолчанию | Описание |
|-------|-----|--------------|----------|
| `modules.system.shell.zsh.enable` | `bool` | `false` | Включает модуль. |
| `modules.system.shell.zsh.setAsDefaultShell` | `bool` | `true` | Делать ли Zsh оболочкой по умолчанию для всех новых пользователей. |

---

## Что делает модуль

При `enable = true` выполняются настройки:

1. `programs.zsh.enable = true` — активирует пакет и стандартную конфигурацию Zsh в NixOS.
2. Если `setAsDefaultShell = true`, то `users.defaultUserShell = pkgs.zsh`, что делает Zsh логин-шеллом по умолчанию.

---

## Пример использования

```nix
modules.system.shell.zsh = {
  enable = true;           # включаем модуль
  setAsDefaultShell = true;# (необязательно, true по умолчанию)
};
```

---

> Файл модуля: `config/modules/x86_64-linux/system/shell/zsh/default.nix`

*Документация сформирована автоматически.* 