{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkOption mkIf mkDefault types;
in {
    options.modules.system.boot = {
        enable = mkEnableOption "Configures boot loader";

        legacyPatch = mkOption {
            type = types.bool;
            default = false;
            description = "Enable kernel params patch for legacy hardware stability (acpi=off, noapic, nolapic)";
        };

        efiSupport = mkOption {
            type = types.bool;
            default = true;
            description = "Whether to enable EFI support for GRUB";
        };

        efiInstallAsRemovable = mkOption {
            type = types.bool;
            default = true;
            description = "Whether to install GRUB as a removable EFI binary";
        };

        theme = mkOption {
            type = types.nullOr types.path;
            default = null;
            description = "Path to theme for GRUB";
        };

        splashImage = mkOption {
            type = types.nullOr types.path;
            default = null;
            description = "Path to background image for GRUB";
        };
    };

    config = let
        cfg = config.modules.system.boot;
    in mkIf cfg.enable {
        boot.loader.grub = {
            enable = true;
            device = mkDefault config.myConfig.targetDisk;
            efiSupport = cfg.efiSupport;
            efiInstallAsRemovable = cfg.efiInstallAsRemovable;
            useOSProber = mkDefault true;
            theme = mkIf (cfg.theme != null) cfg.theme;
            splashImage = mkIf (cfg.splashImage != null) cfg.splashImage;
        };

        boot.kernelParams = mkIf cfg.legacyPatch [
            "acpi=off"
            "noapic"
            "nolapic"
            "processor.max_cstate=0"
            "intel_idle.max_cstate=0"
        ];
    };
}
