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

(defmacro after (file &rest forms)
  "Evaluate FORMS after FILE is loaded."
  (declare (indent 1))
  `(eval-after-load ,file
     '(progn ,@forms)))

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
(setq backup-by-copying t      ; don't clobber symlinks
      temporary-file-directory "~/.emacs.d/tmp/"
      backup-directory-alist '(("." . "~/.emacs.d/tmp/")))

;; store autosaved files in the system's tmp dir
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

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

(add-to-list 'custom-theme-load-path "~/.emacs.d/vendor/color-theme-molokai/")

(setq color-theme-is-global t)
(setq frame-background-mode 'dark)
;; (load-theme 'zenburn t)
(load-theme 'molokai t)

(require 'init-completion)
(require 'init-edit)
(require 'init-ui)

;;(require 'init-c)         ; C
(require 'init-functions)
(require 'init-idlwave)   ; IDL - IDLwave
;; (require 'init-latex)     ; LaTeX mode
;; (require 'init-lisp)      ; Emacs-Lisp
(require 'init-org)
(require 'init-python)    ; Python
(require 'init-spell)
(require 'init-tags)      ; Ctags
(require 'init-text)      ; Markdown, rst, bbcode, ...
(require 'init-web)       ; PHP - HTML - CSS

;; Lua
(setq auto-mode-alist (cons '("\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

;; Set mode for each file type
(setq auto-mode-alist
  (append
    '(("\\.[kz]?sh\\'" . sh-mode)
      ("zsh" . sh-mode)
      ("bash" . sh-mode)
      ("profile" . sh-mode)
      ("[Mm]akefile\\'" . makefile-mode)
      ("\\.mk\\'" . makefile-mode)
      ("\\.conf\\'" . conf-mode)
      ("\\rc\\'" . conf-mode)
     )
     auto-mode-alist))

;;----------------------------------------------------------------------
;; Keyboard shortcuts
;;----------------------------------------------------------------------
(windmove-default-keybindings 'meta)

;; use cua-mode only for rectangles
;; (setq cua-enable-cua-keys nil)
;; (cua-mode t)
(cua-selection-mode t)

;; Mouse
;; (global-set-key [mouse-3] 'imenu)

;; Font size
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; Use regex searches by default.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "\C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

  ;; Jump to a definition in the current file. (Protip: this is awesome.)
  (global-set-key (kbd "C-x C-i") 'imenu)


(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-b") 'ido-switch-buffer)
(global-set-key (kbd "<C-escape>") 'ibuffer-list-buffers)
(global-set-key (kbd "C-/") 'comment-dwim)
(global-set-key (kbd "\M-;") 'comment-dwim)
(global-set-key (kbd "M-/") 'hippie-expand)

(global-set-key (kbd "<C-tab>") 'other-window)
;; (global-set-key (kbd "<C-S-tab>") '(lambda () (interactive) (other-window -1)))
;; (global-set-key (kbd "<C-S-iso-lefttab>") '(lambda () (interactive) (other-window -1)))

(global-set-key (kbd "M-r") 'replace-string)
(global-set-key (kbd "M-g") 'goto-line)
;; Completion that uses many different methods to find options.

;; supprime le formatage du paragraphe courant
(global-set-key (kbd "M-Q") 'remove-hard-wrap-paragraph)

(global-set-key [kp-enter] 'newline-and-indent)
(define-key global-map (kbd "RET") 'newline-and-indent)

(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c r") 'org-remember)

(global-set-key (kbd "C-c c") 'server-edit)
(global-set-key (kbd "C-c f") 'flyspell-buffer)
;;(global-set-key (kbd "C-c f") 'find-file-in-project)
(global-set-key (kbd "C-c g") 'magit-status)
;; (global-set-key (kbd "C-c h") 'htmlfontify-buffer)
(global-set-key (kbd "C-c k") 'kill-this-buffer)
(global-set-key (kbd "C-c m") 'magit-status)
(global-set-key (kbd "C-c n") 'clean-up-buffer-or-region)
;;(global-set-key (kbd "C-c n") 'esk-cleanup-buffer)
(global-set-key (kbd "C-c q") 'refill-mode)
(global-set-key (kbd "C-c r") 'revert-buffer)
;;(global-set-key (kbd "C-c s") 'sr-speedbar-toggle)
(global-set-key (kbd "C-c t") 'trim-whitespace)
(global-set-key (kbd "C-c v") 'refill-mode)
(global-set-key (kbd "C-c x") 'eshell)
(global-set-key (kbd "C-c y") '(lambda ()
                                 (interactive)
                                 (popup-menu 'yank-menu)))
(global-set-key (kbd "C-c y") 'bury-buffer)


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
(global-set-key [\C-f8] 'kill-compilation)
(global-set-key [\C-f9] 'recompile)
(global-set-key [\C-f10] 'menu-bar-mode)

;;----------------------------------------------------------------------
;; Buffers
;;----------------------------------------------------------------------
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("Config" (filename . ".emacs.d/"))
               ("Dired" (mode . dired-mode))
               ("Emacs" (or
                         (name . "^\\*scratch\\*$")
                         (name . "^\\*Buffer List\\*$")
                         (name . "^\\*Completions\\*$")
                         (name . "^\\*Messages\\*$")
                         (name . "^\\*vc\\*$")
                         (name . "^\\*Warnings\\*$")))
               ("IDL" (or
                       (mode . idlwave-mode)
                       (name . "^\\*idl\\*$")))
               ("Org" (or
                       (name . "^\\*Calendar\\*$")
                       (name . "^diary$")
                       (mode . org-mode)
                       (mode . muse-mode)))
               ("Programming" (or
                               (mode . python-mode)
                               (mode . lua-mode)
                               (name . "\\*Python.*\\*")
                               (mode . emacs-lisp-mode)
                               (mode . sh-mode)))
               ("Writing" (or
                           (mode . tex-mode)
                           (mode . latex-mode)
                           (mode . markdown-mode)
                           (mode . rst-mode)))
               ("Mail" (or
                        (mode . message-mode)
                        (mode . mail-mode)))
               ))))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

;;----------------------------------------------------------------------
;; Load modules / modes
;;----------------------------------------------------------------------
;; Show images et compressed files
(setq auto-image-file-mode t)
(setq auto-compression-mode t)

;; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Ack
(autoload 'ack-and-a-half-same "ack-and-a-half" nil t)
(autoload 'ack-and-a-half "ack-and-a-half" nil t)
(autoload 'ack-and-a-half-find-file-same "ack-and-a-half" nil t)
(autoload 'ack-and-a-half-find-file "ack-and-a-half" nil t)

;; Create shorter aliases
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

;; Tramp (remote files editing)
(setq tramp-default-method "ssh")

;; powerline
(require 'powerline)
(powerline-default-center)

;; distinguish files with the same name
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)

;; Version Control
(autoload 'magit-status "magit" nil t)
(autoload 'svn-status "psvn" nil t)
(setq vc-svn-diff-switches 'nil)
(setq vc-diff-switches '("-bBu"))

;; Mail
(defun my-mail-mode-hook ()
  (auto-fill-mode 1)
  (setq fill-column 72)
  (set compose-mail-check-user-agent nil)
  (flyspell-mode)
  ;; (abbrev-mode 1)
  ;; (local-set-key "\C-Xk" 'server-edit)
  )
(add-hook 'mail-mode-hook 'my-mail-mode-hook)

;; (add-hook 'mail-mode-hook
;;           (lambda ()
;;             (font-lock-add-keywords nil
;;                '(("^[ \t]*>[ \t]*>[ \t]*>.*$"
;;                   (0 'mail-multiply-quoted-text-face))
;;                  ("^[ \t]*>[ \t]*>.*$"
;;                   (0 'mail-double-quoted-text-face))))))

;; (autoload 'sc-cite-original "supercite" nil t)
(autoload 'muttrc-mode "muttrc-mode.el" "Major mode to edit muttrc files" t)
(setq auto-mode-alist (append '(("muttrc\\'" . muttrc-mode)
                                ("/mutt" . mail-mode)) auto-mode-alist))

;; pkgbuild
(autoload 'pkgbuild-mode "pkgbuild-mode.el" "PKGBUILD mode." t)
(setq auto-mode-alist (append '(("/PKGBUILD$" . pkgbuild-mode)) auto-mode-alist))

;; fill-column-indicator
;; (turn-on-fci-mode)
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)
(setq fci-rule-width 5)

;;----------------------------------------------------------------------
;; Pymacs and Rope for Python
;;----------------------------------------------------------------------
(when (require 'pymacs nil 'noerror)
  ;; (eval-after-load "pymacs"
  ;;  '(add-to-list 'pymacs-load-path "~/.emacs.d/site-lisp/"))
  (setq pymacs-load-path (list (expand-file-name "~/.emacs.d/vendor")))

  ;; setup pymacs
  (autoload 'pymacs-apply "pymacs")
  (autoload 'pymacs-call "pymacs")
  (autoload 'pymacs-eval "pymacs" nil t)
  (autoload 'pymacs-exec "pymacs" nil t)
  (autoload 'pymacs-load "pymacs" nil t)
  (autoload 'pymacs-autoload "pymacs")

  (pymacs-load "python")            ; some python tools
  (pymacs-load "ropemacs" "rope-")  ; python refactoring and support
  (pymacs-load "license")           ; shortcut function to insert license headers

  ;; setup ropemacs
  (setq ropemacs-guess-project t
        ropemacs-enable-autoimport t
        ropemacs-autoimport-modules '("os" "os.path" "sys")
        ropemacs-global-prefix "C-c p"
        ropemacs-enable-shortcuts nil))

;;----------------------------------------------------------------------
;; Evil
;;----------------------------------------------------------------------
(setq evil-default-cursor t
      evil-find-skip-newlines t  ; f, F, t, T skip over newlines to find a character
      ;; evil-move-cursor-back nil  ; don't move backwards when exiting Insert state
      ;; evil-want-visual-char-semi-exclusive t
      )

(setq evil-leader/leader ","
      evil-leader/in-all-states t)

(require 'evil-leader)
(require 'evil)
(evil-mode 1)

(dolist (mode '(inferior-emacs-lisp-mode
                pylookup-mode
                idlwave-mode
                idlwave-shell-mode
                idlwave-shell-electric-debug-mode))
  (push mode evil-emacs-state-modes))

;; (define-key evil-normal-state-map (kbd "C-:") 'eval-expression)
(define-key evil-normal-state-map (kbd "SPC") 'hs-toggle-hiding)
(define-key evil-normal-state-map (kbd "C-b") 'ido-switch-buffer)

(define-key evil-motion-state-map "\C-e" 'end-of-line)
(define-key evil-motion-state-map "\C-y" nil)

(define-key evil-insert-state-map "\C-e" 'end-of-line)
(define-key evil-insert-state-map "\C-y" 'yank)

(evil-leader/set-key
  "b" 'ido-switch-buffer
  "B" 'ibuffer-list-buffers
  "w" 'save-buffer
  "W" 'save-some-buffers
  "k" 'kill-buffer-and-window
  "K" 'kill-this-buffer
  "d" 'dired-jump
  "g" 'compile

  "n" 'split-window-horizontally
  "v" 'split-window-vertically
  "c" 'delete-window
  "N" 'make-frame-command
  "C" 'delete-frame

  "m" 'magit-status)

(require 'surround)
(global-surround-mode 1)

;;----------------------------------------------------------------------------
;; Customize configuration
;;----------------------------------------------------------------------------
(defun my-short-hostname()
  (string-match "[0-9A-Za-z]+" system-name)
  (substring system-name (match-beginning 0) (match-end 0)))

;; Load different config file in text mode or gui mode.
;; (if (null window-system)
;;     (load-file "~/.emacs.d/texmode-emacs.el")
;;   (load-file "~/.emacs.d/gui.el"))

;; Load configuration for this host only, ie ~/.emacs.d/myhostname.el if exist
(if (file-exists-p
     (downcase (concat "~/.emacs.d/" (my-short-hostname) ".el")))
    (load-file (downcase "~/.emacs.d/" (my-short-hostname) ".el")))

(if (file-readable-p
     (expand-file-name "~/.emacs.d/init-priv.el"))
    (require 'init-priv))
