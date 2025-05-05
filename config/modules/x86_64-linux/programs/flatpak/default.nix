{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.programs.flatpak;
in {
  options.modules.programs.flatpak = {
    enable = mkEnableOption "Flatpak support";
  };

  config = mkIf cfg.enable {
    services.flatpak = {
        enable = true;
    };

    systemd.services.flatpak-repo = {
        wantedBy = [ "multi-user.target" ];
        path = [ pkgs.flatpak ];
        script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        '';
    };
  };
}