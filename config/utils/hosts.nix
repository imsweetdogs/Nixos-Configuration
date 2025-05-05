{ inputs, flake, ... }: 
    let
        mkHost = {system, hostname, modules? []}: inputs.nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
                inherit inputs flake;
            };
            modules = [
                { networking.hostName = hostname; }
                inputs.disko.nixosModules.disko
                inputs.home-manager.nixosModules.home-manager
                "${flake.conf.structure.utils}/users.nix"
                "${flake.conf.structure.overlays}/nixpkgs"
            ] ++ modules;
        };

        architectures = builtins.attrNames (builtins.readDir flake.conf.structure.hosts);

        processArch = arch:
            let
                archPath = "${flake.conf.structure.hosts}/${arch}";
                hostTypes = builtins.attrNames (builtins.readDir archPath);

                processHostType = hostType: 
                let
                    configPath = "${archPath}/${hostType}/default.nix";
                    hostname = if flake ? conf.system.hostname then flake.conf.system.hostname else hostType;
                in
                    if builtins.pathExists configPath then
                        [{
                            name = hostType;
                            value = mkHost (
                                let
                                    config = import configPath {inherit inputs flake;};
                                in config // { 
                                    system = arch;
                                    hostname = hostname;
                                }
                            );
                        }]
                    else [];
            in builtins.concatLists (map processHostType hostTypes);

        allHosts = builtins.concatLists (map processArch architectures);
    in builtins.trace "Initialization hosts" builtins.listToAttrs allHosts