{ flake, ... }: {
  modules.hardware.graphics.enable = true;
  modules.hardware.tablet.enable = true;
  modules.hardware.bluetooth = {
    enable = true;
    gui = true;  # Включаем графический интерфейс Blueman
  };
  modules.hardware.disks = {
    enable = true;
    gui = true;  # Включаем графический интерфейс gnome-disks
  };
  modules.hardware.pipewire = {
    enable = true;
    lowLatency = true; # Включаем настройки низкой задержки для аудио, может вызывать проблемы с прерываниями звука
  };
}