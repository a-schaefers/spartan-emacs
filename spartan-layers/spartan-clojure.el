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
                   `(clojure-mode . ("clojure-lsp")))
  (with-eval-after-load 'eglot
    (setq eglot-connect-timeout 60)))

(use-package cider
  :straight t
  :defer t
  :init
  ;; https://manueluberti.eu/2023/03/25/clojure-lsp.html
  (setq-default cider-eldoc-display-for-symbol-at-point nil)

  (defun mu-cider-disable-eldoc ()
    "Let LSP handle ElDoc instead of CIDER."
    (remove-hook 'eldoc-documentation-functions #'cider-eldoc t))

  (add-hook 'cider-mode-hook #'mu-cider-disable-eldoc))

(provide 'spartan-clojure)
