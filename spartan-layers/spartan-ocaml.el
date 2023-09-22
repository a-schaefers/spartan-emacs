;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; https://github.com/ocaml/tuareg

(use-package tuareg-mode
  :straight t
  :defer t
  :config
  (when (executable-find "ocaml-lsp")
    (add-hook 'tuareg-mode-hook 'eglot-ensure)
    (add-hook 'tuareg-ts-mode-hook 'eglot-ensure) ; for the future
    ))

(provide 'spartan-ocaml)
