;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; https://github.com/immerrr/lua-mode

(use-package zig-mode
  :straight t
  :defer t
  :config
  (when (executable-find "zls")
    (add-hook 'zig-mode-hook 'eglot-ensure)
    (add-hook 'zig-ts-mode-hook 'eglot-ensure) ; for the future
    ))

(provide 'spartan-zig)
