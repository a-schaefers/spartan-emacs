;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(add-to-list 'spartan-package-list 'go-mode)

(when (executable-find "gopls")
        (with-eval-after-load 'eglot
          (add-hook 'go-mode-hook 'eglot-ensure)))

(provide 'spartan-go)
