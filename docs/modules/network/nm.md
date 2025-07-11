# network.nm

Модуль включает NetworkManager как основной сервис управления сетью.

---

## Опции

| Опция | Тип | По умолчанию | Описание |
|-------|-----|--------------|----------|
| `modules.network.nm.enable` | `bool` | `false` | Включает модуль. |

---

## Что делает модуль

При `enable = true` добавляется конфигурация:

```nix
networking.networkmanager.enable = true;
```

Это активирует службу `NetworkManager`, позволяя управлять подключениями через `nmcli`, `nmtui` или графические апплеты.

---

## Пример использования

```nix
modules.network.nm = {
  enable = true;
};
```

---

> Файл модуля: `config/modules/x86_64-linux/network/nm/default.nix`

*Документация сформирована автоматически.* 