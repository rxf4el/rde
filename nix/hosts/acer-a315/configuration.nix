# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, ... }: {
  
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/5fd51d6c-04b2-43f7-8612-cec6e7b3b8ba";
      fsType = "btrfs";
      options = [ "subvol=nixos" "noatime" "discard" "space_cache" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/9B90-BEDD";
      fsType = "vfat";
    };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 8;
  # powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  nixpks.config = { allowUnfree = true; };

  powerManagement.enable = true;
  powerManagement.powertop.enable = true;

  services.tlp = {
    enable = true;
    extraConfig = ''
      CPU_SCALING_GOVERNOR_ON_BAT=powersave
      ENERGY_PERF_POLICY_ON_BAT=powersave
      START_CHARGE_THRESH_BAT0=90
      STOP_CHARGE_THRESH_BAT0=95
    '';
  };

  boot = { 
    cleanTmpDir = true;
    kernelParams = ["ipv6.disable=0" "acpi_brightness=vendor"];
    initrd.checkJournalingFS = false;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  environment.pathsToLink = [
    "/share/zsh" # required for zsh autocomplete for systemctl
  ];

  networking = {
    hostName = "ixy";
    networkmanager.enable = true;
    firewall.enable = false;
    # extraHosts = "127.0.0.1 ${config.networking.hostName}.lan";
  };

  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    # font = "Lat2-Terminus16";
    font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    # keyMap = "br-abnt2"; # moved to layout.nix
  };


  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  hardware.openrazer.enable = true;
  
  # Hardware
  hardware = {
    cpu = { amd.updateMicrocode = true; };
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
    };
    pulseaudio = { 
      enable = true; 
      package = pkgs.pulseaudioFull;
      support32Bit = true;
      # tcp.enable = true; # need for mpd
    };    
  };

  # $ nix search wget
  environment.systemPackages = with pkgs; [
    (aspellWithDicts (ps: with ps; [en pt_BR]))
    zsh
    wget gitFull curl
    gcc gnupg gnumake autoconf cmake
    pciutils usbutils coreutils lm_sensors
    ntfs3g dosfstools
    cacert acpi
    rlwrap direnv tree man file
    sbcl guile perl
    xsel zlib
    nix-index nix-prefetch-git cachix
    xclip xorg.xset xorg.xsetroot xorg.xrdb xdotool
    xorg.xmodmap xorg.xprop xorg.xrandr xorg.xfontsel
    xorg.xbacklight
  ];

  fonts = {
    enableGhostscriptFonts = true;
    # fontconfig.dpi = 192;
    fonts = with pkgs; [
      corefonts liberation_ttf open-sans
      (nerdfonts.override {
        fonts = [ "BitstreamVeraSansMono" "CascadiaCode" 
                  "DejaVuSansMono" "FantasqueSansMono" "FiraCode" 
                  "Hack" "Iosevka" "JetBrainsMono" "Meslo" "Monoid"
                  "ShareTechMono" "SourceCodePro" ]; })
    ];
  };
  
  location.provider = "geoclue2";
  services.redshift.enable = true;
  
  # Services
  services = {
    acpid = { enable = true; };
    # printing.enable = true;
    openssh = { enable = true; };
    dbus = {
      enable = true;
      packages = with pkgs; [gnome3.dconf];
    };
    xserver = {
      enable = true;
      displayManager.startx.enable = true;
      windowManager.stumpwm.enable = true;
      videoDrivers = ["amdgpu"];
      # libinput.enable = true; # enable touchpad support;
    };
  };

  users.defaultUserShell = pkgs.zsh;
  
  users.extraUsers.${config.rde.usename} = {
    isNormalUser = true;
    uid = 1000;
    group = "users";
    extraGroups = [ "wheel" "networkmanager" 
                    "audio" "video" 
                    "input" "disk" ];
  };

  system.stateVersion = "20.09";
}
