;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(use-package yasnippet
  :straight t
  :defer t
  :hook (prog-mode-hook . yas-minor-mode))

(use-package eglot
  :after yasnippet
  :straight t
  :defer t)

(provide 'spartan-eglot)
