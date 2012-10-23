;; (set-default-font "Inconsolata-10")
;; (setq font-use-system-font t)

;; redraw the display before process queued input events
;; http://www.masteringemacs.org/articles/2011/10/02/improving-performance-emacs-display-engine/
;; (setq redisplay-dont-pause t)

;; Window title
;; (setq frame-title-format '(buffer-file-name "Emacs: %b (%f)" "Emacs: %b"))
;; (setq frame-title-format '(buffer-file-name "%b [%f]" "%b"))

;; visible beep
;; (setq visible-bell t)

;; Use the clipboard, pretty please, so that copy/paste "works"
(setq x-select-enable-clipboard t)

;; cursor
;; (setq cursor-type 'bar)
;; (blink-cursor-mode nil)
;; (blink-cursor-mode (- (*) (*) (*)))     ; don't blink !

;; x-window specific settings
;; (if (eq window-system 'x)
;;   (progn
;;     (menu-bar-mode 1)
;;   )
;;   (menu-bar-mode 0)
;; )

;; statusbar: column, line, time
(column-number-mode 1)
(line-number-mode 1)
(display-time-mode 1)
(setq display-time-24hr-format t)

;; 'y' = yes, 'n' = no
(defalias 'yes-or-no-p 'y-or-n-p)

;;------------------------------------------------------------
;; Speedbar
;;------------------------------------------------------------
;; (require 'sr-speedbar)
;; (setq sr-speedbar-right-side nil)
(setq speedbar-show-unknown-files t)
(setq speedbar-use-images t)

;; cedet
;; (global-ede-mode 1)
;; (require 'semantic/sb)
;; (semantic-mode 1)


(provide 'init-ui)
