;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; https://github.com/emacsorphanage/terraform-mode

(add-to-list 'spartan-package-list 'terraform-mode)

(with-eval-after-load 'terraform-mode
  (custom-set-variables
   '(terraform-indent-level 2))


  (with-eval-after-load 'eglot
      (add-to-list 'eglot-server-programs
                   `(terraform-mode . ("terraform-lsp"))))

  (when (executable-find "terraform-lsp")
    (with-eval-after-load 'eglot
      (add-hook 'terraform-mode-hook 'eglot-ensure))))

(provide 'spartan-terraform)
