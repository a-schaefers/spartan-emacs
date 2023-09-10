;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; requires spartan-elisp

(use-package slime
  :straight t
  :demand t
  :config

  (with-eval-after-load 'spartan-elisp
    (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
    (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode))

  (setq inferior-lisp-program "sbcl")
  (add-to-list 'auto-mode-alist '("\\.sbclrc\\'" . lisp-mode))
  (add-to-list 'auto-mode-alist '("\\.cl\\'" . lisp-mode)))

(provide 'spartan-commonlisp)
