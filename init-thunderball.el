;;----------------------------------------------------------------------------
;; Jedi
;;----------------------------------------------------------------------------

(eval-when-compile (require 'jedi nil t))
(setq jedi:setup-keys t)
(setq jedi:server-command
      (list "python2" jedi:server-script))
(add-hook 'python-mode-hook 'jedi:setup)
