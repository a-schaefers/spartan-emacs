;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; expects 'pyls'

;; usage: https://www.emacswiki.org/emacs/PythonProgrammingInEmasc

(add-hook 'python-mode-hook (lambda ()
                                (setq-local tab-width 4)))

(when (executable-find "pylsp")
  (add-hook 'python-mode-hook 'eglot-ensure))

(provide 'spartan-python)
