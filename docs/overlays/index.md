# Оверлеи Nixpkgs

В этом репозитории определён единственный оверлей, расположенный по пути `config/overlays/nixpkgs/default.nix`. Он расширяет каждую оценку (`evaluation`) **nixpkgs**, предоставляя удобные ярлыки на несколько различных *каналов* NixOS/Nixpkgs.

В будущем возможно будут добавляться ещё оверлеи, каждый должен импортироваться по отдельности!

## Зачем это нужно

Иногда требуется более новая (или, наоборот, более старая) версия пакета, чем та, что поставляется с каналом по умолчанию. Вместо того чтобы импортировать собственную копию *nixpkgs* в каждом модуле, мы подключаем дополнительные каналы **один раз** через оверлей и делаем их доступными как простые атрибуты в наборе `pkgs`.

## Доступные каналы

| Атрибут               | Ветка / тег upstream | `allowUnfree` |
|-----------------------|----------------------|---------------|
| `pkgs.stable`         | `nixos-25.05`        | ❌ |
| `pkgs.stable-unfree`  | `nixos-25.05`        | ✅ |
| `pkgs.unstable`       | `nixos-unstable`     | ❌ |
| `pkgs.unstable-unfree`| `nixos-unstable`     | ✅ |
| `pkgs.master`         | `master`             | ❌ |
| `pkgs.master-unfree`  | `master`             | ✅ |

Все каналы импортируются для текущей системы (`system`) и с параметром `allowBroken = true`, что позволяет собирать помеченные как «сломанные» (`broken`) пакеты при явном запросе.

## Пример использования

```nix
{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.stable.git # Git из стабильной ветки
    pkgs.unstable.helix # Более свежий Helix из unstable
    pkgs.master-unfree._1password # Проприетарный 1Password из master с не-свободной лицензией
    pkgs.git # Git из нестабильной ветки (а точнее той, что будет указана в качестве follows в инпутах флейка)
  ];
}
```

Атрибуты выше ведут себя точно так же, как обычный набор `pkgs`: вы можете обращаться к `lib`, `stdenv` и другим податрибутам. Это всего лишь дополнительные *записи* в верхнем уровне результирующего набора nixpkgs.

## Подробности реализации

Ниже приведена сокращённая версия реализации оверлея для справки:

```nix
# config/overlays/nixpkgs/default.nix
{ inputs, ... }: {
  nixpkgs.overlays = [
    (final: _prev: {
      stable          = import inputs.stable   { inherit (final) system; config = { allowBroken = true;               }; };
      stable-unfree   = import inputs.stable   { inherit (final) system; config = { allowBroken = true; allowUnfree = true; }; };
      unstable        = import inputs.unstable { inherit (final) system; config = { allowBroken = true;               }; };
      unstable-unfree = import inputs.unstable { inherit (final) system; config = { allowBroken = true; allowUnfree = true; }; };
      master          = import inputs.master   { inherit (final) system; config = { allowBroken = true;               }; };
      master-unfree   = import inputs.master   { inherit (final) system; config = { allowBroken = true; allowUnfree = true; }; };
    })
  ];
}
```

## Как добавить ещё один канал

Нужен дополнительный канал? Сделать это очень просто:

1. Добавьте новый вход (`input`) в блок `inputs` файла `flake.nix`, например:

   ```nix
   myFork.url = "github:myuser/nixpkgs/my-branch";
   ```
2. Добавьте соответствующий атрибут внутри функции оверлея:

   ```nix
   myFork = import inputs.myFork { inherit (final) system; };
   ```

После этого новый атрибут `pkgs.myFork` станет доступен во всех модулях.

---

*Автоматически сгенерировано и переведено через AI.*
