# system.sysctl

Модуль оптимизирует параметры ядра Linux через `sysctl`.

---

## Опции

| Опция | Тип | По умолчанию | Описание |
|-------|-----|--------------|----------|
| `modules.system.sysctl.enable` | `bool` | `false` | Включает модуль. |
| `modules.system.sysctl.extraSettings` | `attrset` | `{}` | Дополнительные или переопределяющие параметры sysctl. |

---

## Значения по умолчанию

При активации модуль задаёт следующие параметры:

| Ключ | Значение |
|------|----------|
| `vm.swappiness` | `10` |
| `vm.vfs_cache_pressure` | `50` |
| `net.core.netdev_max_backlog` | `100000` |
| `net.core.somaxconn` | `100000` |
| `net.ipv4.tcp_rmem` | `4096 87380 16777216` |
| `net.ipv4.tcp_wmem` | `4096 65536 16777216` |

Эти настройки направлены на снижение свопинга, улучшение работы сети и кеша VFS.

---

## Что делает модуль

Комбинирует `defaultSettings` с `extraSettings` посредством `mkMerge` и передаёт
результат в `boot.kernel.sysctl`.

---

## Пример использования

```nix
modules.system.sysctl = {
  enable = true;
  extraSettings = {
    "net.ipv4.tcp_fin_timeout" = "15";
    "vm.max_map_count" = "262144";
  };
};
```

---

> Файл модуля: `config/modules/x86_64-linux/system/sysctl/default.nix`

*Документация сформирована автоматически.* 