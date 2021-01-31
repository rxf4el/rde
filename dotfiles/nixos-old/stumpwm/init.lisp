;; -*- lisp -*-
(in-package :stumpwm)

(defun load-file (file)
  (load (concatenate 'string (getenv "XDG_CONFIG_HOME") "~/.stumpwm.d/" file ".lisp")))

(set-module-dir (concatenate 'string (getenv "XDG_CONFIG_HOME") "/.stumpwm.d/contrib"))

(load-file "commands")
(load-file "custom")
;; (load-file "mode-line")
(load-file "rotate-windows")
(load-file "shifting")
(load-file "swank")
(load-file "swap-window")
(load-file "defprogram")
(load-file "vikeys")
(load-file "groups")

;; Set Desktop Wallpaper
(run-shell-command "~/.fehbg")

;; Start Emacs Server
(run-shell-command "emacs --daemon")

;; Change Prefix-Key
(set-prefix-key (kbd "C-t"))

;;; defprogram sets the keys to be
;;;  s-(key) for just shelling out (command)
;;;  s-(uppercase key) for focusing the window named (command)
;;;  C-t C-(upcase key) for "run-or-pull"-ing the window named (command)
;;(defprogram conkeror "conkeror" "c" '(:class "Conkeror") :rat t)
(defprogram emacs "emacsclient -c" "e" '(:class "Emacs"))
(defprogram firefox "firefox" "f" '(:class "Firefox"))
;;(defprogram qutebrowser "qutebrowser" "B" '(:class "Qutebrowser"))
;;(defprogram urxvt "urxvt" "a" '(:class "Alacritty"))
(defprogram alacritty "alacritty" "x" '(:class "Alacritty"))
;;(defprogram mpv "mpv \"$(xclip -o)\"" "m" '(:class "mpv"))

;;; Keyboard special keys
(global "XF86MonBrightnessUp" "increase-brightness")
(global "XF86MonBrightnessDown" "decrease-brightness")
(global "XF86AudioRaiseVolume" "increase-volume")
(global "XF86AudioLowerVolume" "decrease-volume")
(global "XF86AudioMute" "mute")
(global "XF86AudioNext" "next-song")
(global "XF86AudioPrev" "prev-song")
(global "XF86AudioStop" "stop-song")
(global "XF86AudioPlay" "play-song")
(global "Print" "screenshot")

;;; Using super (Windows, Command on Mac, etc) key for fancy window functions
(global "s-n" "next")
(global "s-p" "prev")
(global "s-r" "rotate-windows")
(global "s-s" "swap-window")
(global "s-O" "gnext")
(global "s-I" "gprev")

;;; programs that are under the stumpwm root map
;; (bind "C-d" "rofi")
(bind "C-s" "swank")
(bind "DEL" "logout")
(bind "C-DEL" "suspend")

;; look and feel
(set-fg-color "grey95")
(set-bg-color "grey15")
(set-win-bg-color "black")
(set-border-color "grey10")
(set-focus-color "grey72")
(set-unfocus-color "grey30")

(setf *startup-message* "May the source be with you!")

(setf *maxsize-border-width* 3)
(setf *normal-border-width* 3)
(setf *window-border-style* :thin)
(setf *mode-line-border-color* "grey15")
(set-msg-border-width 1)
(set-frame-outline-width 1)
(set-normal-gravity :center)

;;; starts the mode-line
;; (stumpwm:toggle-mode-line (stumpwm:current-screen)
;;                           (stumpwm:current-head))
;; (if (not (head-mode-line (current-head)))
;;     (toggle-mode-line (current-screen) (current-head)))
