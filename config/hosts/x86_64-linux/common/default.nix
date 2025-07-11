{ inputs, flake, ... }: {
  hostname = "common";
  modules = [
    "${flake.conf.path}/users"
    ./system.nix
  ];
}