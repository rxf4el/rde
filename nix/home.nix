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
      # latex-packages
      colorpicker
      vscode
      nodejs
      nodePackages.nodemon
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.javascript-typescript-langserver
      postman
      rnix-lsp
      python3
    ];
    cli-packages = with pkgs; [
      # neovim
      # youtube-dl
      neofetch
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
      # ungoogled-chromium
      feh
      imagemagick
      scrot
      ffmpeg
      pavucontrol
      pulsemixer
      font-manager ];
    other-packages = with pkgs; [
      poppler
      zathura
      gnome3.adwaita-icon-theme];
    
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
          cdc = "cd /media/data/00-09-configs/01-NixOS";
          cdd = "cd /media/data";
          sails = "node ${home.homeDirectory}/.node-packages/bin/sails";
          x = "startx";
        };

      };

      rofi = {
        enable = true;
        theme = "dmenu";
        # extraConfig = "";
      };
      
    };

    # - - - - - - - - - - - - - - - - - - - - - -    
    xsession = {
      windowManager.i3 = rec {
        enable = true;
        package = pkgs.i3-gaps;
        config = {
          modifier = "Mod4";
          terminal = "alacritty";
          menu = "rofi -show run";
          workspaceAutoBackAndForth = false;
          keybindings =
            let mod = "Mod4";
            in lib.mkOptionDefault {
              "${mod}+Ctrl+d" = "exec ${pkgs.rofi}/bin/rofi -show run";
              "${mod}+Tab" = "workspace back_and_forth";
              "${mod}+t" = "workspace number 1";
              "${mod}+Ctrl+f" = "fullscreen toggle";
              "${mod}+Ctrl+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
              "${mod}+Ctrl+e" = "exec ${pkgs.emacs}/bin/emacsclient -c -a ''";
              "${mod}+Ctrl+b" = "exec ${pkgs.firefox}/bin/firefox";
              "${mod}+Ctrl+c" = "exec i3-nagbar -t warning -m 'Do you really want to exit i3?' -B 'Yes, exit i3' 'i3-msg exit'";
              # "${mod}+m" = "bar toggle";
              "${mod}+d" = null;
              "${mod}+w" = null;
              "${mod}+f" = null;
              "${mod}+e" = null;
              "${mod}+Return" = null;
            };

          bars = [
            {
              position = "bottom";
              statusCommand = "${pkgs.i3status}/bin/i3status";
              mode = "invisible";
              colors = {
                background = "#000000";
                statusline = "#ffffff";
                separator = "#666666";
              };
            }
          ];
          
          startup = [{
            command = "exec ~/.fehbg";
            always = true;
            notification = false;
          }];
          
        };
      };
    };
    # - - - - - - - - - - - - - - - - - - - - - -
    
    services = {
      network-manager-applet.enable = true;
      blueman-applet.enable = true;
    };
    
  };
    
}
