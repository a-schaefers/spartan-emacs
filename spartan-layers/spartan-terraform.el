;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; https://github.com/emacsorphanage/terraform-mode

(add-to-list 'spartan-package-list 'terraform-mode)

(with-eval-after-load 'terraform-mode
  (custom-set-variables
   '(terraform-indent-level 2)))

(provide 'spartan-terraform)
