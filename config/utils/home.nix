{ inputs, flake, arch, ... }:
    let
        users = flake.conf.system.users;
        mkHome = user: import "${flake.conf.structure.home}/${arch}/${user}";
    in
        builtins.listToAttrs (map (user: { name = user; value = mkHome user; }) users)
