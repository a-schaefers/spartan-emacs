;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; https://github.com/ocaml/tuareg

(use-package php-mode
  :straight t
  :defer t)

(when (bound-and-true-p spartan-php-langserver)
  (add-hook 'php-mode-hook 'eglot-ensure)
  (add-hook 'php-ts-mode-hook 'eglot-ensure) ; for the future
  )

(provide 'spartan-php)
