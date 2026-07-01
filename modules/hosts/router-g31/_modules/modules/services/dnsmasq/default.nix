{ config, pkgs, self, ... }:

{
    # 5. НАСТРОЙКА DNSMASQ (Разделение доменов для дома и удаленщиков)
    services.dnsmasq = {
        enable = true;
        settings = {
        interface = [ "enp1s0" "tailscale0" ];
        bind-dynamic = true;

        # Локальный DHCP-пул для домашних устройств
        dhcp-range = "192.168.0.10,192.168.0.250,24h";
        dhcp-option = [
            "option:router,192.168.0.1"
            "option:dns-server,192.168.0.1"
        ];

        # Регистрируем обе зоны как локальные
        domain = [ "home.lan" "rybakov.lan" ];
        local = [ "/home.lan/" "/rybakov.lan/" ];

        # Привязываем домены к ПРАВИЛЬНЫМ адресам
        address = [
            "/home.lan/192.168.0.1"       # Локальные клиенты дома идут на внутренний IP
            "/rybakov.lan/100.11.22.33"   # ⚠️ ВПИШИ СЮДА РЕАЛЬНЫЙ TAILSCALE IP ЭТОГО СЕРВЕРА
        ];

        expand-hosts = true;
        server = [ "77.88.8.1" "77.88.8.8" ];
        };
    };
}