{ flake, ... }: {
  modules.display.xorg = {
    enable = true;
    videoDrivers = [ "amdgpu" ];  
  };
  modules.display.dm.sddm.enable = true;
  modules.display.wm.hyprland.enable = true;
}