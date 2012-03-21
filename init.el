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

;;----------------------------------------------------------------------
;; Keyboard shortcuts
;;----------------------------------------------------------------------
;; use cua-mode only for rectangles
(setq cua-enable-cua-keys nil)
(cua-mode t)

;; Mouse
;; (global-set-key [mouse-3] 'imenu)

;; (global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-b") 'ido-switch-buffer)
(global-set-key (kbd "<C-escape>") 'ibuffer-list-buffers)
(global-set-key (kbd "C-/") 'comment-dwim)
(global-set-key "\M-;" 'comment-dwim)

(global-set-key (kbd "<C-tab>") 'other-window)
;; (global-set-key (kbd "<C-S-tab>") '(lambda () (interactive) (other-window -1)))
;; (global-set-key (kbd "<C-S-iso-lefttab>") '(lambda () (interactive) (other-window -1)))

(global-set-key (kbd "M-r") 'replace-string)
(global-set-key (kbd "M-g") 'goto-line)

;; supprime le formatage du paragraphe courant
(global-set-key (kbd "M-Q") 'remove-hard-wrap-paragraph)

(global-set-key [kp-enter] 'newline-and-indent)
(define-key global-map (kbd "RET") 'newline-and-indent)

;; (global-set-key [delete] 'delete-backward-char)

(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c r") 'org-remember)

(global-set-key (kbd "C-c c") 'server-edit)
(global-set-key (kbd "C-c f") 'flyspell-buffer)
;; (global-set-key (kbd "C-c h") 'htmlfontify-buffer)
(global-set-key (kbd "C-c k") 'kill-this-buffer)
(global-set-key (kbd "C-c m") 'magit-status)
(global-set-key (kbd "C-c n") 'clean-up-buffer-or-region)
(global-set-key (kbd "C-c q") 'refill-mode)
;;(global-set-key (kbd "C-c s") 'sr-speedbar-toggle)
(global-set-key (kbd "C-c t") 'trim-whitespace)
(global-set-key (kbd "C-c v") 'refill-mode)
(global-set-key (kbd "C-c x") 'eshell)
(global-set-key (kbd "C-c y") '(lambda ()
                                 (interactive)
                                 (popup-menu 'yank-menu)))

;; fonction keys
(global-set-key [f1]  (lambda () (interactive) (manual-entry (current-word))))
(global-set-key [f2]  (lambda () (interactive) (find-file "~/org/notes.org")))
(global-set-key [f3]  's/org-agenda)
(global-set-key [f5]  'kill-this-buffer)
(global-set-key [f6]  'repeat-complex-command)
(global-set-key [f7]  'other-window)
(global-set-key [f8]  'deft)
(global-set-key [f9]  'compile)
(global-set-key [f10] 'my-toggle-menu-and-scrollbar)
(global-set-key [f11] 'toggle-truncate-lines)
(global-set-key [f12] 'grep)

(global-set-key [\C-f1] 'compile)
(global-set-key [\C-f3] 'next-error)
(global-set-key [\C-f4] 'previous-error)
(global-set-key [\C-f9] 'recompile)
(global-set-key [\C-f10] 'kill-compilation)
