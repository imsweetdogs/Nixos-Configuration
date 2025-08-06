{ lib, path, ... }:

with lib;

let
  scanModules = dir:
    let
      contents = builtins.readDir dir;
      dirs = filterAttrs (name: type: type == "directory" && name != ".git") contents;
      hasDefault = name: builtins.pathExists (dir + "/${name}/default.nix");
      imports = mapAttrsToList (name: _: dir + "/${name}") (filterAttrs (name: _: hasDefault name) dirs);
      submodules = concatLists (mapAttrsToList (name: _: scanModules (dir + "/${name}")) dirs);
    in
      imports ++ submodules;
  modulesPath = path;
  allModules = scanModules modulesPath;
in { imports = allModules; }