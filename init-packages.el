(require 'package)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;; (defvar melpa-exclude-packages
;;   '(slime)
;;   "Don't install Melpa versions of these packages.")

;; ;; Don't take Melpa versions of certain packages
;; (setq package-filter-function
;;       (lambda (package version archive)
;;         (and
;;          (not (memq package '(eieio)))
;;          (or (not (string-equal archive "melpa"))
;;              (not (memq package melpa-exclude-packages))))))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(starter-kit
                      starter-kit-eshell
                      starter-kit-lisp
                      ack-and-a-half
                      autopair
                      auto-complete
                      browse-kill-ring
                      deft
                      evil
                      evil-leader
                      fill-column-indicator
                      flycheck
                      flymake
                      flymake-cursor
                      jinja2-mode
                      js2-mode
                      less-css-mode
                      lua-mode
                      magit
                      markdown-mode
                      multi-web-mode
                      php-mode
                      python
                      pkgbuild-mode
                      popwin
                      rainbow-mode
                      scss-mode
                      smart-tab
                      undo-tree
                      virtualenv
                      yasnippet
                      zenburn-theme
                      )
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(provide 'init-packages)
