{ inputs, flake, ... }: {
  hostname = "common";
  modules = [
    "${flake.conf.path}/overlays/nixpkgs"
    ./system.nix
  ];
}