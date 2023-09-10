;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; requires spartan-elisp

(use-package clojure-mode
  :straight t
  :defer t
  :init

  (with-eval-after-load 'spartan-elisp
    (add-hook 'clojure-mode-hook          #'enable-paredit-mode))

  (when (executable-find "clojure-lsp")
    (add-hook 'clojure-mode-hook 'eglot-ensure))

  :config
  (require 'eglot)
  (add-to-list 'eglot-server-programs
                   `(clojure-mode . ("clojure-lsp"))))

(provide 'spartan-clojure)
