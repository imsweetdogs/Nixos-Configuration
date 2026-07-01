{ ... }: {
    flake.nixosModules.modules = { ... }: {
        imports = [
            ./_modules
        ];
    };
}
