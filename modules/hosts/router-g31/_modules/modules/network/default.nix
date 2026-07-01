{ config, pkgs, self, ... }: 

{
    modules.system.network = {
        enable = true;
        hostname = "router-g31";
        modemmanager = {
            enable = true;
            startfix = true;
        };
    };

    # 1. СЕТЕВОЙ ИНТЕРФЕЙС (Локальная сеть дома)
    networking.interfaces.enp1s0 = {
        ipv4.addresses = [{ 
            address = "192.168.0.1"; 
            prefixLength = 24; 
        }];
    };

    # 2. ФАЙРВОЛ (Открываем порты для локалки и доверяем Tailscale)
    networking.firewall.interfaces.enp1s0 = { 
        allowedTCPPorts = [ 53 80 443 ]; 
        allowedUDPPorts = [ 53 67 68 ];
    };
    networking.firewall.trustedInterfaces = [ "tailscale0" ];

    # 3. NFTABLES NAT (Без старого iptables)
    networking.nat.enable = false; 
    networking.nftables = {
        enable = true;
        tables.custom-nat = {
        family = "ip";
        content = ''
            chain postrouting {
            type nat hook postrouting priority 100; policy accept;

            # Маскарадим локальный трафик, уходящий через сотовый модем
            oifname "wwp0s29f7u2c2" ip saddr 192.168.0.0/24 masquerade
            }
        '';
        };
    };
}