;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; https://github.com/immerrr/lua-mode

(use-package erlang
  :straight t
  :defer t
  :config
  (when (executable-find "elixir_ls")
    (add-hook 'erlang-mode-hook 'eglot-ensure)
    (add-hook 'erlang-ts-mode-hook 'eglot-ensure) ; for the future
    ))

(provide 'spartan-erlang)
