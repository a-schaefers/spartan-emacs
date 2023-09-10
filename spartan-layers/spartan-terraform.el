;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; expects: terraform-ls
;; usage: https://github.com/emacsorphanage/terraform-mode

(use-package terraform-mode
  :straight t
  :defer t
  :init
  (custom-set-variables
   '(terraform-indent-level 2))
  (require 'eglot)
  (add-to-list 'eglot-server-programs
                   `(terraform-mode . ("terraform-ls" "serve")))
  (when (executable-find "terraform-ls")
    (add-hook 'terraform-mode-hook 'eglot-ensure)))

(provide 'spartan-terraform)
