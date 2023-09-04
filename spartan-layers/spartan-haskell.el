;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; expects: hls
;; usage: https://github.com/haskell/haskell-mode

(use-package haskell-mode
  :straight t
  :demand t
  :config
  (when (executable-find "hls")
        (with-eval-after-load 'eglot
          (add-hook 'haskell-mode-hook 'eglot-ensure))))

(provide 'spartan-go)
