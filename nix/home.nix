{ config, lib, pkgs, ... }:
{

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.rxf4el = let
    latex-packages = pkgs.texlive.combine {
      inherit (pkgs.texlive) scheme-medium
        wrapfig capt-of preview lxfonts latexmk
        natbib biblatex biblatex-abnt fourier xpatch
        ctex xetex minted fvextra amsmath upquote
        catchfile xstring framed dvipng;
    };
    dev-packages = with pkgs; [
      gnupg
      latex-packages
    ];
    cli-packages = with pkgs; [
      # neovim
      # youtube-dl
      bat
      exa
      nixfmt
      unzip
      killall
      htop
      ripgrep
      wget
      graphviz ];
    media-packages = with pkgs; [
      # obs-studio # Software for video recording and live streaming
      feh
      imagemagick
      scrot
      ffmpeg
      pavucontrol
      font-manager ];
    other-packages = with pkgs; [
      poppler
      zathura ];
    
    home-packages = dev-packages ++ cli-packages ++ media-packages
                    ++ other-packages;
  in rec {
    home = {
      homeDirectory = "/home/rxf4el";
      # sessionVariable = {};
      stateVersion = "20.09";
      keyboard = {
        layout = "br";
        variant = "abnt2";
        options = [ "ctrl:nocaps" ];
      };
      packages = home-packages;
    };

    xdg = {
      enable = true;
      dataHome = "${home.homeDirectory}/.local/share";
      configHome = "${home.homeDirectory}/.config";
      userDirs = {
        enable = true;
        desktop = "${home.homeDirectory}/desktop";
        documents = "${home.homeDirectory}/documents";
        download = "${home.homeDirectory}/downloads";
        publicShare = "${home.homeDirectory}/public";
        templates = "${home.homeDirectory}/templates";
      };
      mimeApps = {
        associations.added = {
          "x-scheme-handler/org-protocol" = [
            "org-protocol.desktop" ];
        };
      };
    };
    
    programs = {
      alacritty.enable = true;
      emacs.enable = true;
      firefox.enable = true;
      fzf.enable = true;

      git = {
        enable = true;
        package = pkgs.gitAndTools.gitFull;
        userName = "rxf4el";
        userEmail = "rxf4el@gmail.com";
      };

      zsh = {
        enable = true;
        autocd = true;
        dotDir = ".config/zsh";
        # enableAutosuggestions = true;
        defaultKeymap = "emacs";
        history.path = "${xdg.dataHome}/zsh/zsh_history";
        shellAliases = {
          ls = "exa --group-directories-first --sort=type --classify";
	        l = "ls -lh";
	        la = "ls -lha";
	        x = "startx";
        };

      };
    };

    services = {
      network-manager-applet.enable = true;
      blueman-applet.enable = true;
    };
    
  };
    
}
