;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; https://github.com/immerrr/lua-mode

(use-package forth-mode
  :straight t
  :defer t
  :config
  (when (executable-find "forth-lsp")
    (require 'eglot)
    (add-to-list 'eglot-server-programs
                 `(forth-mode . ("forth-lsp")))
    (add-hook 'forth-mode-hook 'eglot-ensure)))

(provide 'spartan-forth)
