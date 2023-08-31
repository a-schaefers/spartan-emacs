;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; expects 'pyls'

;; usage: https://www.emacswiki.org/emacs/PythonProgrammingInEmasc

(defun spartan-python-hook ()
  (interactive)
  (setq-local tab-width 4))

(add-hook 'python-mode-hook 'spartan-python-hook)

(when (executable-find "pyls")
  (require 'eglot)
  (add-hook 'python-mode-hook 'eglot-ensure))

(provide 'spartan-python)
