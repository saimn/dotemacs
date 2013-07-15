(autoload 'python "python" "Python editing mode." t)

;; allow inferior Python processes to load modules from the current directory
;; (setq python-remove-cwd-from-path 'nil)

;; Set PYTHONPATH
;; python-load-file not defined, may need to address this
;; (setenv "PYTHONPATH" ".")

;;----------------------------------------------------------------------
;; IPython
;;----------------------------------------------------------------------
(setq
 python-shell-interpreter "ipython2"
 python-shell-interpreter-args ""
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
   "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
   "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
   "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

;;----------------------------------------------------------------------------
;; On-the-fly syntax checking via flymake
;;----------------------------------------------------------------------------
;; (require 'flymake)
;; (load-library "flymake-cursor")

;; ;; Script that flymake uses to check code. This script must be
;; ;; present in the system path: pylint, pyflakes, flake8
;; (setq pycodechecker "flake8")

;; (setq eldoc-echo-area-use-multiline-p t ; eldoc may always resize echo area
;;       py-pychecker-command "flake8"
;;       ;; py-pychecker-command-args '("--output-format=parseable")
;;       python-check-command "flake8")

;; (when (load "flymake" t)
;;   ;; (setq flymake-python-pyflakes-executable "pyflakes")

;;   ;; I want to see at most the first 4 errors for a line.
;;   (setq flymake-number-of-errors-to-display 4)

;;   (defun flymake-pycodecheck-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;            (local-file (file-relative-name
;;                         temp-file
;;                         (file-name-directory buffer-file-name))))
;;       (list pycodechecker (list local-file))))

;;   (add-to-list 'flymake-allowed-file-name-masks
;;                '("\\.py\\'" flymake-pycodecheck-init))

;;   (add-hook 'python-mode-hook
;;             (lambda ()
;;               (flymake-mode)
;;               ;; prevent flymake from running over temporary interpreter buffers
;;               ;; (unless (eq buffer-file-name nil) (flymake-mode 1))
;;               ;; flymake shortcuts
;;               (local-set-key [f10] 'flymake-goto-prev-error)
;;               (local-set-key [f11] 'flymake-goto-next-error)
;;               (local-set-key (kbd "C-c C-SPC") 'flymake-mode)
;;               (local-set-key (kbd "M-p") 'flymake-goto-prev-error)
;;               (local-set-key (kbd "M-n") 'flymake-goto-next-error))))

(after 'flycheck
       (flycheck-declare-checker flake8-python2
         "A Python syntax and style checker using Flake8.

For best error reporting, use Flake8 2.0 or newer.

See URL `http://pypi.python.org/pypi/flake8'."
         :command '("flake8-python2"
                    (config-file "--config" flycheck-flake8rc)
                    (option "--max-complexity"
                            flycheck-flake8-maximum-complexity
                            flycheck-option-int)
                    (option "--max-line-length"
                            flycheck-flake8-maximum-line-length
                            flycheck-option-int)
                    source-inplace)
         :error-patterns
         '(("^\\(?1:.*?\\):\\(?2:[0-9]+\\):\\(?:\\(?3:[0-9]+\\):\\)? \\(?4:E[0-9]+.*\\)$"
            error)
           ("^\\(?1:.*?\\):\\(?2:[0-9]+\\):\\(?:\\(?3:[0-9]+\\):\\)? \\(?4:F[0-9]+.*\\)$"
            warning)                           ; Flake8 >= 2.0
           ("^\\(?1:.*?\\):\\(?2:[0-9]+\\):\\(?:\\(?3:[0-9]+\\):\\)? \\(?4:W[0-9]+.*\\)$"
            warning)                           ; Flake8 < 2.0
           ("^\\(?1:.*?\\):\\(?2:[0-9]+\\):\\(?:\\(?3:[0-9]+\\):\\)? \\(?4:C[0-9]+.*\\)$"
            warning)                           ; McCabe complexity in Flake8 > 2.0
           ("^\\(?1:.*?\\):\\(?2:[0-9]+\\):\\(?:\\(?3:[0-9]+\\):\\)? \\(?4:N[0-9]+.*\\)$"
            warning)                           ; pep8-naming Flake8 plugin.
           ;; Syntax errors in Flake8 < 2.0, in Flake8 >= 2.0 syntax errors are caught
           ;; by the E.* pattern above
           ("^\\(?1:.*\\):\\(?2:[0-9]+\\): \\(?4:.*\\)$" error))
         :modes 'python-mode)

       (add-to-list 'flycheck-checkers 'flake8-python2)
)

;;----------------------------------------------------------------------------
(add-hook 'python-mode-hook
          (lambda ()
            ;; disable highlighting of unknown includes
            ;; (semantic-toggle-decoration-style "semantic-decoration-on-includes" nil)

            ;; (add-hook 'local-write-file-hooks 'untabify-buffer)

            (eldoc-mode 1)
            (fci-mode 1)
            (auto-fill-mode 1)
            (setq tab-width 4
                  mode-name "py"
                  python-skeleton-autoinsert t)

            ;; Keybindings
            (define-key python-mode-map "\C-m" 'newline-and-indent)
            (define-key python-mode-map "\C-ci" 'rope-auto-import)
            (define-key python-mode-map "\C-ct" 'rope-show-calltip)))

(provide 'init-python)
