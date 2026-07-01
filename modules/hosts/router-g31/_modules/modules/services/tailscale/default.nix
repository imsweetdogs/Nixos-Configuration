{ config, ... }: {
    # 4. VPN ПРОВАЙДЕР
    preservation.preserveAt."/persistent".directories = [ "/var/lib/tailscale" ];
    services.tailscale.enable = true;
}