
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
             ;; '("marmalade" . "http://marmalade-repo.org/packages/") t)
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
                      flymake
                      flymake-cursor
                      jinja2-mode
                      less-css-mode
                      lua-mode
                      magit
                      markdown-mode
                      php-mode
                      python
                      pkgbuild-mode
                      popwin
                      rainbow-mode
                      scss-mode
                      smart-tab
                      undo-tree
                      virtualenv
                      web-mode
                      yasnippet
                      zenburn-theme
                      )
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(provide 'init-packages)
