;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; https://github.com/immerrr/lua-mode

(use-package erlang
  :straight t
  :defer t
  :config
  (when (executable-find "elixir_ls")
    (add-hook 'elixir-mode-hook 'eglot-ensure)))

(provide 'spartan-erlang)
