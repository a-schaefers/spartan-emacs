;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; expects: terraform-ls
;; usage: https://github.com/emacsorphanage/terraform-mode

(use-package terraform-mode
  :straight t
  :demand t
  :config
  (custom-set-variables
   '(terraform-indent-level 2))
  (with-eval-after-load 'eglot
      (add-to-list 'eglot-server-programs
                   `(terraform-mode . ("terraform-ls" "serve"))))
  (when (executable-find "terraform-ls")
        (with-eval-after-load 'eglot
          (add-hook 'terraform-mode-hook 'eglot-ensure))))

(provide 'spartan-terraform)
