;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; https://github.com/immerrr/lua-mode

(use-package elixir-mode
  :straight t
  :defer t
  :config
  (when (executable-find "elixir-ls")
    (add-hook 'elixir-mode-hook 'eglot-ensure)))

(provide 'spartan-elixir)
