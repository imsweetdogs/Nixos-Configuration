{
  description = "Sweetdogs Nixos system configuration";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";

    sops-nix.url = "github:Mic92/sops-nix";
    impermanence.url = "github:/nix-community/impermanence";

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
  };

  outputs = { self, flake-parts, ... }@inputs: flake-parts.lib.mkFlake { inherit inputs; } {
    systems = inputs.nixpkgs.lib.systems.flakeExposed;

    flake = rec {
      conf = import ./config;

      nixosConfigurations = import "${conf.path}/hosts" {
        inherit inputs;
        flake = self;
      };
    };
  };
}