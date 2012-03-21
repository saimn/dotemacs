
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(starter-kit
                      starter-kit-bindings starter-kit-eshell
                      starter-kit-lisp starter-kit-js
                      autopair
                      browse-kill-ring
                      deft
                      flymake-cursor
                      less-css-mode
                      lua-mode
                      magit
                      magithub
                      markdown-mode
                      php-mode
                      popwin
                      rainbow-mode
                      smart-tab
                      yasnippet
                      zenburn-theme
                      )
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(provide 'init-packages)
