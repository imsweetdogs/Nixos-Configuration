{
    structure = {
        overlays = ./overlays;
        secrets = ./secrets;
    };

    system = {
        basePassword = "$6$pokedim13$2HDvjLbVa6wItmJRywWvxO2dB2Wxopjvt3DY9CU3qMJc/8Ho6eoV8PWcUG/0M03avtMb1DYKQT63ZpYqPCUWL1"; # mkpasswd -m sha512crypt -S
        timeZone = "Europe/Moscow";
        stateVersion = "25.05";
        users = ["sweetdogs"];
        # hostname = "my-pc";
    };
}