{ ... }: let
    scanDir = dir:
        let
            entries = builtins.readDir dir;
            subDirs = builtins.filter (name: entries.${name} == "directory") (builtins.attrNames entries);
            result = builtins.concatMap (name:
                let subDir = dir + "/${name}"; in
                (if builtins.pathExists (subDir + "/default.nix") then [ subDir ] else [ ]) ++ scanDir subDir
            ) subDirs;
        in result;
in {
    imports = scanDir ./.;
}
