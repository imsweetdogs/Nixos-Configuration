{ config, pkgs, self, ... }: {
    boot.kernelPackages = pkgs.linuxPackages_6_6;

    modules.system.boot = {
        enable = true;
        legacyPatch = true; # Всё ниже обязательно для старых устройств
        efiSupport = false;
        efiInstallAsRemovable = false;
    };

    boot.kernel.sysctl = {
        "net.ipv4.ip_forward" = "1";
        "net.ipv4.ip_default_ttl" = "65";

        "net.core.default_qdisc" = "fq_codel";
        "net.ipv4.tcp_congestion_control" = "bbr";

        "net.core.netdev_max_backlog" = "10000";

            # Настройка буферов
        "net.core.rmem_max" = 8388608;
        "net.core.wmem_max" = 8388608;
        "net.ipv4.tcp_rmem" = "4096 87380 8388608";
        "net.ipv4.tcp_wmem" = "4096 65536 8388608";

        "net.ipv4.tcp_keepalive_time" = "300";   # Проверять соединение каждые 5 минут
        "net.ipv4.tcp_keepalive_intvl" = "15";   # Интервал между проверками
        "net.ipv4.tcp_keepalive_probes" = "5";

        "net.ipv4.tcp_timestamps" = "0";          # Выключаем метки времени (палево для МТС/Билайн)

        "net.netfilter.nf_conntrack_max" = "131072"; # Оптимально для 2-4ГБ ОЗУ на G31
        "net.netfilter.nf_conntrack_tcp_timeout_established" = "600";
        "net.netfilter.nf_conntrack_tcp_timeout_time_wait" = "30"; # Быстрее освобождаем порты

            # Базовая безопасность внешнего IP модема
        "net.ipv4.tcp_syncookies" = "1";
        "net.ipv4.icmp_echo_ignore_broadcasts" = "1";
        "net.ipv4.icmp_ignore_bogus_error_responses" = "1";
    };
}