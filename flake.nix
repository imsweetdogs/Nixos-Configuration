{
    inputs = {
        master.url = "github:nixos/nixpkgs/master";
        unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        stable.url = "github:nixos/nixpkgs/nixos-26.05";
        nixpkgs.follows = "unstable";

        preservation.url = "github:nix-community/preservation";
        flake-parts.url = "github:hercules-ci/flake-parts";
        import-tree.url = "github:vic/import-tree";

        disko = {
            url = "github:nix-community/disko";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; }
        (inputs.import-tree ./modules);
}