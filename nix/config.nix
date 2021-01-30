{ config, lib, pkgs, ... }:

{
  rde.enable = true;
  rde.username = "rxf4el";
  rde.name = "Rafael Mironiuc Marte";
  rde.font = "Iosevka";
  rde.fontSize = 11;
  # rde.workDir = "/home/rxf4el/work";
  # rde.security.yubikey.enable = true;
  rde.direnv.enable = true;
  # rde.emacs.enable = true;
  # rde.emacs.preset.tropin.enable = true;
}
