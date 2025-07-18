;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(use-package yasnippet
  :ensure t
  :defer t
  :hook (prog-mode-hook . yas-minor-mode))

(use-package eglot
  :ensure t
  :after yasnippet
  :defer t)

(provide 'spartan-eglot)
