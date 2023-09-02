;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; expects: terraform-lsp
;; usage: https://github.com/emacsorphanage/terraform-mode

(use-package terraform-mode
  :straight t
  :demand t
  :config
  (custom-set-variables
   '(terraform-indent-level 2)))

(provide 'spartan-terraform)
