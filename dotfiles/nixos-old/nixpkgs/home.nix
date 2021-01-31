{ config, pkgs, ... }:

let

  latex = pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-medium
      wrapfig capt-of preview lxfonts latexmk
      natbib biblatex biblatex-abnt fourier xpatch
      ctex xetex minted fvextra amsmath upquote catchfile
      xstring framed dvipng;
  };

  userBase = with pkgs; [
    # audio
    pulsemixer
    # image
    feh sxiv imagemagickBig scrot ffmpeg
    # office
    poppler zathura
    # themes
    gnome3.adwaita-icon-theme bibata-cursors-translucent
    font-manager
    # utils
    bat stow htop neofetch zip unzip gzip unrar bzip2 xz
    dropbox fd exa redshift
    # video
    autorandr vulkan-loader
    # libs
    imlib2 libtool
  ];

  devBase = with pkgs; [
    gcc clojure leiningen
    hugo
    adoptopenjdk-bin
    pandoc gnuplot graphviz
    sqlite ripgrep
    diffutils file
    # latex
  ];

  nixTools = with pkgs; [
    nixpkgs-fmt nix-update rnix-lsp
  ];

in

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.overlays = [
    # (import (builtins.fetchTarball {
    #   url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz; })
    # )
    #(import ./overlays/python3.nix)
    (self: super:
      {
        python3Env = super.buildEnv {
          name = "python3Env";
          paths = [
            (self.python3.withPackages (
              ps: with ps; [
                python-language-server
                pyflakes
                pip
              ]
            ))
            self.mypy
            self.black
            self.pytest
          ];
        };
      })
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = { username = "rxf4el";
           homeDirectory = "/home/rxf4el";
           stateVersion = "21.03";
           keyboard = { layout = "br";
                        variant = "abnt2";
                        options = ["ctrl:nocaps"];
           };
           packages = userBase ++ devBase ++ nixTools;
         };

  xdg = {
    enable = true;
    mimeApps = {
      associations.added = {
        "x-scheme-handler/org-protocol" = [
          "org-protocol.desktop" ];
      };
    };
  };

  programs = {
    alacritty = { enable = true; };
    
    emacs = { enable = true;
              # package = pkgs.emacsGcc;
              # extraPackages = (epkgs: [ epkgs.vterm ] );
            };

    firefox = { enable = true; };

    git = { enable = true;
            userName = "rxf4el";
            userEmail = "rxf4e1@gmail.com";
          };

    fzf = { enable = true;
            enableBashIntegration = true;
            defaultOptions = [ "--color=bg+:24" ];
          };
  };

  # services = { emacs.enable = true; };

  # services = {
  #   redshift = {
  #     enable = true;
  #     latitude = "-23.5";
  #     longitude = "-46.6";
  #   };
  # };
}
