{
    description = "Sweetdogs Nixos system configuration";

    inputs = {
        flake-parts.url = "github:hercules-ci/flake-parts";

        master.url = "github:nixos/nixpkgs/master";
        unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        stable.url = "github:nixos/nixpkgs/nixos-24.11";
        nixpkgs.follows = "unstable";

        disko = {
            url = "github:nix-community/disko";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        hyprland.url = "github:hyprwm/Hyprland";
    };

    outputs = { self, flake-parts, ... }@inputs: flake-parts.lib.mkFlake { inherit inputs; } {
        systems = inputs.nixpkgs.lib.systems.flakeExposed;

        flake = {
            conf = builtins.trace "Importing structure config" import ./config;

            nixosConfigurations = import "${self.conf.structure.utils}/hosts.nix" {
                inherit inputs;
                flake = self;
            };
        };
    };
}