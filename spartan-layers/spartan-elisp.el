;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(add-to-list 'spartan-package-list 'paredit)

;; paredit makes (((((()))))) manageable
(defun spartan-lisp-hook ()
  (require 'paredit)
  (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
  (add-hook 'ielm-mode-hook             #'enable-paredit-mode))

(add-hook 'after-init-hook 'spartan-lisp-hook)

(provide 'spartan-elisp)
