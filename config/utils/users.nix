{ flake, ... }: {
    imports = map (user: "${flake.conf.structure.users}/${user}") flake.conf.system.users;
}