{ config, lib, pkgs, ... }:

{
  console.useXkbConfig = true;
  services.xserver = {
    layout = "br";
    xkbVariant = "abnt2";
    # xkbOptions = "ctrl:nocaps, grp:win_space_toggle, grp:rctrl_switch";
  };
}
