{ inputs, flake, arch, ... }:
    let
        users = flake.conf.system.users;
        mkHome = user: import "${flake.conf.structure.home}/${arch}/${user}";
    in
        builtins.mapAttrs (name: _: mkHome name) users
