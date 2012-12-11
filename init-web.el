;;------------------------------------------------------------
;; PHP
;;------------------------------------------------------------

(autoload 'php-mode "php-mode" "PHP editing mode" t)
;; (autoload 'php-html-helper-mode "html-helper-mode" "html-helper-mode" t)
;; (add-auto-mode 'php-mode "\\.php[345]?\\'\\|\\.phtml\\." "\\.(inc|tpl)$" "\\.module$")

;; Manuel php en français
(setq php-manual-url "http://fr.php.net/manual/fr/")

;; (add-hook 'php-mode-hook
;;           (lambda ()
;;             (require 'flymake-php)
;;             (flymake-mode t)))

(eval-after-load "php-mode"
  '(progn
     (define-key php-mode-map (kbd "RET") 'reindent-then-newline-and-indent)))

(add-to-list 'auto-mode-alist '("\\.inc\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . html-mode))

;;------------------------------------------------------------
;; CSS
;;------------------------------------------------------------

(autoload 'rainbow-mode "rainbow-mode" "Highlight color names in buffer" t)
(autoload 'css-mode "css-mode" "CSS editing mode" t)

(defun my-css-mode-hook ()
  (setq css-indent-offset 2)
  (define-key css-mode-map "\C-c s" 'css-insert-section)
  (autopair-mode -1)
  (rainbow-mode 1)
  (setq scss-sass-command (expand-file-name "~/.gem/ruby/1.9.1/bin/sass"))
  (setq scss-sass-options (quote ("--debug-info"))))

(add-hook 'css-mode-hook 'my-css-mode-hook)
(add-hook 'scss-mode-hook 'my-css-mode-hook)

(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

(defun css-insert-section (section)
  "Inserts a css section."
  (interactive "sSection: ")
  (insert (concat "/*--[ " section " ]"))
  (while (< (point) (+ 70 (point-at-bol)))
    (insert "-"))
  (insert (concat "*/\n" "\n")))

;;------------------------------------------------------------
;; JS
;;------------------------------------------------------------

(autoload 'js2-mode "js2-mode" nil t)

(add-hook 'js2-mode-hook
          '(lambda ()
             (setq mode-name "js2")
             (setq js-indent-level 2)
             ))

(setq js2-use-font-lock-faces t
      js2-mode-must-byte-compile nil
      js2-basic-offset 2
      js2-indent-on-enter-key t
      js2-auto-indent-p t
      js2-bounce-indent-p t)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . js2-mode))

;; On-the-fly syntax checking
;; (eval-after-load 'js
;;   '(add-hook 'js-mode-hook 'flymake-jslint-load))

;;------------------------------------------------------------
;; HTML
;;------------------------------------------------------------

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php$" . web-mode))

(defun web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)

  (define-key web-mode-map (kbd "C-n") 'web-mode-match-tag)
  )

(add-hook 'web-mode-hook 'web-mode-hook)

;; Indenter automatiquement lorsque l'on appuie sur entrée
;; (defun my-html-helper-load-hook ()
;;   (define-key html-mode-map (kbd "RET") 'newline-and-indent))
;; (add-hook 'html-helper-load-hook 'my-html-helper-load-hook)

(setq auto-mode-alist
      (append '(("\\.x[ms]l\\'" . nxml-mode)
                ;; ("\\.[sx]?html?\\'" . html-mumamo)
                ;; ("\\.tpl\\'" . smarty-html-mumamo)
                ;; ("\\.[sx]?html?\\'" . html-mode)
                ;; ("\\.tpl\\'" . html-mode)
                ("\\.sql\\'" . sql-mode))
              auto-mode-alist))

;;------------------------------------------------------------
;; NXHTML & MUMAMO
;;------------------------------------------------------------

;; (load "~/.emacs.d/site-lisp/nxhtml/autostart.el")
;; (autoload 'html-mumamo "~/.emacs.d/site-lisp/nxhtml/autostart.el")
;; ;; (autoload 'django-html-mumamo "~/.emacs.d/site-lisp/nxhtml/autostart.el")
;; (autoload 'smarty-html-mumamo "~/.emacs.d/site-lisp/nxhtml/autostart.el")
;; ;; (autoload 'jinja-html-mumamo "jinja.el")
;; (require 'mumamo-fun)
;; (require 'jinja)

;; (setq
;;  nxhtml-global-minor-mode t
;;  mumamo-chunk-coloring 'submode-colored
;;  ;; mumamo-background-colors nil
;;  nxhtml-skip-welcome t
;;  indent-region-mode t
;;  rng-nxml-auto-validate-flag nil
;;  nxml-degraded t)

(provide 'init-web)
