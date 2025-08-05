{ inputs, flake, ... }:

let
  mkHost = { system ? null, hostname, modules ? [] }:
    let
      finalSystem = system;
    in inputs.nixpkgs.lib.nixosSystem {
      system = finalSystem;
      specialArgs = {
        inherit inputs flake;
      };
      modules = [
        "${flake.conf.path}/overlays/nixpkgs"
        "${flake.conf.path}/users"
        { networking.hostName = hostname; }
        inputs.disko.nixosModules.disko
      ] ++ modules;
    };

  architectures = builtins.filter
    (arch: (builtins.readDir "${flake.conf.path}/hosts")."${arch}" == "directory")
    (builtins.attrNames (builtins.readDir "${flake.conf.path}/hosts"));

  processArch = arch:
    let
      archPath = "${"${flake.conf.path}/hosts"}/${arch}";
      hostTypes = builtins.attrNames (builtins.readDir archPath);

      # Функция для обработки типа хоста
      processHostType = hostType:
        let
          configPath = "${archPath}/${hostType}/default.nix";
        in
          if builtins.pathExists configPath then
            [{
              name = hostType;
              value = mkHost (
                let
                  config = import configPath { inherit inputs flake; };
                in config // { system = arch; }
              );
            }]
          else
            [];
    in
      builtins.concatLists (map processHostType hostTypes);

  allHosts = builtins.concatLists (map processArch architectures);
in builtins.listToAttrs allHosts