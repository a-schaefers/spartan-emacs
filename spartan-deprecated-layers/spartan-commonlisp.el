;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; requires spartan-elisp

(use-package slime
  :straight t
  :defer t
  :init
  (setq inferior-lisp-program "sbcl")
  (add-to-list 'auto-mode-alist '("\\.sbclrc\\'" . lisp-mode))
  (add-to-list 'auto-mode-alist '("\\.cl\\'" . lisp-mode)))

(provide 'spartan-commonlisp)
