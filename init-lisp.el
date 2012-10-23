(autoload 'emacs-lisp-mode "emacs-lisp-mode" nil t)

;; Compile .emacs
(defun compile-init-file ()
  (let ((byte-compile-warnings '(unresolved)))
    (byte-compile-file user-init-file)
    (message "Emacs init file saved and compiled.")))

(defun my-emacs-lisp-mode-hook ()
  (turn-on-eldoc-mode)
  (paredit-mode -1)
  ;; (if (string-equal buffer-file-name (expand-file-name user-init-file))
  ;;     (progn (add-hook 'after-save-hook 'compile-init-file t t)
  ;;            ))
  )

(add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-mode-hook)

(setq auto-mode-alist
      (cons '("\\.el\\'" . emacs-lisp-mode) auto-mode-alist))

(provide 'init-lisp)
