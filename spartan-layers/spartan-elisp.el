;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; paredit makes (((((()))))) manageable
(use-package paredit
  :straight t
  :defer t
  :init
  (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
  (add-hook 'ielm-mode-hook             #'enable-paredit-mode))

(provide 'spartan-elisp)
