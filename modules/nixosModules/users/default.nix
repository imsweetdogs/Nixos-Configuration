{ ... }: let
    usersDir = ./_users;
    entries = builtins.readDir usersDir;
    isDir = name: entries.${name} == "directory";
    dirNames = builtins.filter isDir (builtins.attrNames entries);
    dirPaths = map (name: usersDir + "/${name}") dirNames;
in {
    flake.nixosModules.users = { ... }: {
        imports = dirPaths;
    };
}
