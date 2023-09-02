;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; expects: gopls
;; usage: https://github.com/dominikh/go-mode.el

(use-package go-mode
  :straight t
  :demand t
  :config
  (when (executable-find "gopls")
        (with-eval-after-load 'eglot
          (add-hook 'go-mode-hook 'eglot-ensure))))

(provide 'spartan-go)
