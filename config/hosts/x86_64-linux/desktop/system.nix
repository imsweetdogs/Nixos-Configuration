{ lib, flake, modulesPath, ... }: {
  imports = [
    "${flake.conf.path}/overlays/nixpkgs"
    (import "${flake.conf.path}/modules" { path = "${flake.conf.path}/modules/x86_64-linux"; lib = lib; })
    (import "${flake.conf.path}/modules" { path = ./modules; lib = lib; })
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
}