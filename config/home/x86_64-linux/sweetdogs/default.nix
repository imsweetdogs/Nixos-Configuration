{ pkgs, ... }: {
    home = {
        username = "sweetdogs";
        homeDirectory = "/home/sweetdogs";
        stateVersion = "25.05";

        packages = with pkgs; [
            kitty
            firefox
            pavucontrol
        ];
    };
}