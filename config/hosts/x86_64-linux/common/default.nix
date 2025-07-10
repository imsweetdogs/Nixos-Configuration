{ inputs, flake, modulesPath, lib, ... }: {
  hostname = "common";
  modules = [
    "${flake.conf.path}/overlays/nixpkgs"
    (modulesPath + "/installer/scan/not-detected.nix")
    (import "${flake.conf.path}/modules" { path = "${flake.conf.path}/modules/x86_64-linux"; lib = lib; })
    (import "${flake.conf.path}/modules" { path = ./modules; lib = lib; })
  ];
}