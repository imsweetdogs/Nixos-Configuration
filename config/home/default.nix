{ flake, inputs, arch, users, ... }:
let
  importIfExists = user:
    let
      path = "${flake.conf.path}/home/${arch}/${user}/default.nix";
    in
      if builtins.pathExists path then
        {
          name = user;
          value = import path { inherit flake inputs; };
        }
      else null;
  userAttrs = builtins.filter (x: x != null) (map importIfExists users);
in
builtins.listToAttrs userAttrs
