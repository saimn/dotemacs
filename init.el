;;----------------------------------------------------------------------
;; Global settings
;;----------------------------------------------------------------------
;; Turn off mouse interface early in startup to avoid momentary display
;; (if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;(server-start)                        ; enable emacsclient
;(setq major-mode 'text-mode)          ; start in text-mode
(setq inhibit-startup-message t)      ; Don't show startup buffer
(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq browse-url-browser-function 'browse-url-firefox)

;;----------------------------------------------------------------------------
;; paths
;;----------------------------------------------------------------------------
;; Load Path
(let ((default-directory "~/.emacs.d/vendor/"))
  (setq load-path
        (append
         (let ((load-path (copy-sequence load-path))) ;; Shadow
           (append
            (copy-sequence (normal-top-level-add-to-load-path '(".")))
            (normal-top-level-add-subdirs-to-load-path)))
         load-path)))

(setq load-path (cons (expand-file-name "~/.emacs.d") load-path))

;; backup files
;; (setq make-backup-files nil)
;; (setq auto-save-default nil)

(setq
 backup-by-copying t      ; don't clobber symlinks
 temporary-file-directory "~/.emacs.d/tmp/"
 backup-directory-alist '(("." . "~/.emacs.d/tmp/"))
 )

;; Customize file
(setq custom-file (expand-file-name "~/.emacs.d/customize.el"))
(load custom-file)

;; use the Trash for file deletion
;(setq delete-by-moving-to-trash t)
(setq dired-listing-switches "-aFGhl --group-directories-first")

;;----------------------------------------------------------------------
;; Load config
;;----------------------------------------------------------------------

(require 'init-packages)

(setq color-theme-is-global t)
;;(setq frame-background-mode 'dark)
(load-theme 'zenburn t)

(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)

(require 'init-edit)
(require 'init-completion)
