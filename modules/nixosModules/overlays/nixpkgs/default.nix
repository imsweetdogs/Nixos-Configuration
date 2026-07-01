{ inputs, ... }: 

{
  flake.nixosModules."overlays.nixpkgs" = { lib, ... }: {
    
    nixpkgs.overlays = [
      (final: prev: 
        lib.concatMapAttrs (name: input: 
          let 
            base = import input { 
              system = final.stdenv.hostPlatform.system; 
              config = { allowUnfree = true; allowBroken = true; }; 
            };
          in {
            "${name}" = base.extend (_: _: { config = base.config // { allowUnfree = false; }; });
            "${name}-unfree" = base;
          }
        ) { inherit (inputs) stable unstable master; }
      )
    ];

  };
}