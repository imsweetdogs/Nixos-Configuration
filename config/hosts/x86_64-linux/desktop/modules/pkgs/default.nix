{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        polkit_gnome

        kitty
        firefox
        git
        pavucontrol
        waybar
    ];
}