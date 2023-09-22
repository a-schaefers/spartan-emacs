;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; expects: gopls
;; usage: https://github.com/dominikh/go-mode.el

(use-package go-mode
  :straight t
  :defer t
  :init
  (when (executable-find "gopls")
    (add-hook 'go-mode-hook 'eglot-ensure)
    (add-hook 'go-ts-mode-hook 'eglot-ensure) ; for the future
    ))

(provide 'spartan-go)
