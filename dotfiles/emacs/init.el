;; (require 'init-straight)
;; (require 'init-font)
;; (require 'init-util)
;; (require 'init-modal-qwerty)
;; (require 'init-lsp)
;; (require 'init-web)
;; (require 'init-lisp)
;; (require 'init-clojure)
;; (require 'init-hippie-expand)
;; (require 'init-embark)
;; (require 'init-nix)
;; (require 'init-scrolling)
;; (require 'init-markdown)
;; (require 'init-git)
;; (require 'init-org)
;; (require 'init-org-utils)
;; (require 'init-gkroam)
;; (require 'init-completion)
;; (require 'init-window)
;; (require 'init-sidebar)
;; (require 'init-modeline)
;; (require 'init-misc)
;; (require 'init-which-key)
;; (require 'init-readers)

;; (require 'init-server)
;; (require 'init-python)
;; (require 'init-tramp)
;; (require 'init-pass)
;; (require 'init-rime)
;; (require 'init-conf)
;; (require 'init-telega)
(put 'upcase-region 'disabled nil)

;;;; init config file

(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))
;; (if (display-graphic-p)
;;     (org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))
;;   (org-babel-load-file (expand-file-name "~/.emacs.d/config_t.org")))