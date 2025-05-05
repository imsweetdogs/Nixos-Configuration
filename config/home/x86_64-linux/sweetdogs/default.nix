{ pkgs, ... }: {
    imports = [
        ./modules
    ];

    homeModules.term = {
        fastfetch.enable = true;
        kitty.enable = true;
        btop.enable = true;
        yazi.enable = true;
    };

    homeModules.programs = {
        rofi.enable = true;
        waybar.enable = true;
        git.enable = true;
        firefox.enable = true;
        # chromium.enable = true;
    };

    home = {
        username = "sweetdogs";
        homeDirectory = "/home/sweetdogs";
        stateVersion = "25.05";

        packages = with pkgs; [
            pavucontrol
            vesktop

            cmatrix
            pipes-rs
        ];
    };
}