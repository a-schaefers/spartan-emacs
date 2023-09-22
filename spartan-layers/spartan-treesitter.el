;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(use-package treesit-auto
  :straight t
  :demand t
  :config
  (setq treesit-auto-install 't)
  (global-treesit-auto-mode))

(provide 'spartan-treesitter)
