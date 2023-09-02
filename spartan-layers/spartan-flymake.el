;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(use-package flymake
  :straight t
  :demand t
  :config
  (remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake))

(provide 'spartan-flymake)
