;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; expects: gopls
;; usage: https://github.com/dominikh/go-mode.el

(add-to-list 'spartan-package-list 'go-mode)

(when (executable-find "gopls")
        (with-eval-after-load 'eglot
          (add-hook 'go-mode-hook 'eglot-ensure)))

(provide 'spartan-go)
