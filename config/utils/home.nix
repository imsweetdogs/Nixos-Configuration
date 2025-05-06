{ inputs, flake, arch, ... }:
    let
        users = flake.conf.system.users;
        mkHome = user: 
            let
                configPath = "${flake.conf.structure.home}/${arch}/${user}";
            in
                if builtins.pathExists configPath
                then import configPath
                else { };
    in
        builtins.listToAttrs (map (user: { name = user; value = mkHome user; }) users)
