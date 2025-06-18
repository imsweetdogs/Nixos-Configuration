{
    description = "Sweetdogs Nixos system configuration";

    inputs = {
        flake-parts.url = "github:hercules-ci/flake-parts";

        master.url = "github:nixos/nixpkgs/master";
        unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        stable.url = "github:nixos/nixpkgs/nixos-25.05";
        nixpkgs.follows = "unstable";

        disko = {
            url = "github:nix-community/disko";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        inputs.sops-nix.url = "github:Mic92/sops-nix";
    };

    outputs = { self, flake-parts, ... }@inputs: flake-parts.lib.mkFlake { inherit inputs; } {
        systems = inputs.nixpkgs.lib.systems.flakeExposed;

        flake = {
            conf = import ./config;
        };
    };
}