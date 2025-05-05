{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.programs.earlyoom;
in {
  options = {
    modules.programs.earlyoom.enable = mkEnableOption "Earlyoom memory killer";
  };

  config = mkIf cfg.enable {
    services.earlyoom.enable = true;
  };
}