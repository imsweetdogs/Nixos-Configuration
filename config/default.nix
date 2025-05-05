{
    structure = {
        hosts = ./hosts;
        modules = ./modules;
        overlays = ./overlays;
        shells = ./shells;
        users = ./users;
        utils = ./utils;
    };

    system = {
        timeZone = "Europe/Moscow";
        stateVersion = "25.05";
        users = ["sweetdogs"];
        # hostname = "my-pc";
    };
}