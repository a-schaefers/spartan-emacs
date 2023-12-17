;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; https://github.com/ocaml/tuareg

(use-package tuareg-mode
  :straight t
  :defer t
  :config
  (when (executable-find "ocaml-lsp")
    (add-hook 'ocaml-mode-hook 'eglot-ensure)))

(provide 'spartan-ocaml)
