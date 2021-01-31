;; (in-package :stumpwm)
;; (require :swank)
;; (swank-loader:init)
;; (swank:create-server :port 4004
;; 		                 :style swank:*communication-style*
;; 		                 :dont-close t)

;; (defcommand swank (&optional port) ()
;;             (setf stumpwm:*top-level-error-action* :break)
;;             (swank:create-server :port (or port 4004)
;; 		                             :coding-system "utf-8"
;; 		                             :style swank:*communication-style*
;; 		                             :dont-close t)
;;             (message "Starting swank"))

;; Start swank server
;; Load swank.
;; *prefix-key* ; swank will kick this off

;; (load "/home/rxf4el/.quicklisp/dists/quicklisp/software/slime-v2.26/swank-loader.lisp")
;; (swank-loader:init)
;; (defcommand swank () ()
;;             (swank:create-server :port 4005
;;                                  :style swank:*communication-style*
;;                                  :dont-close t)
;;             (echo-string (current-screen) 
;; 	                       "Starting swank. M-x slime-connect RET RET, then (in-package stumpwm)."))
;; (swank)
