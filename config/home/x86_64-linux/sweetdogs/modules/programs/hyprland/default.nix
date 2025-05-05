{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.homeModules.programs.hyprland;
in {
  options.homeModules.programs.hyprland = {
    enable = mkEnableOption "Enable hyprland";
  };
  
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
        
        bind = [
          "$mod, Return, exec, kitty"
          "$mod, Q, killactive"
          "$mod, M, exit"
          "$mod, R, exec, rofi -show drun"
          "$mod, F, fullscreen"
        ]
        ++ (
            # workspaces
            # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
            builtins.concatLists (builtins.genList (i:
                let ws = i + 1;
                in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                ]
            )
            9)
        );

        exec-once = [
            "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
            "waybar"
        ];
        
        monitor = ",1920x1080@165,0x0,1";
        
        input = {
          kb_layout = "us,ru";
          kb_options = "grp:alt_shift_toggle";
          follow_mouse = 1;
        };
      };
    };
  };
}
