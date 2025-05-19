;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(use-package evil
  :if spartan-evil
  :straight t
  :defer t
  :init
  (evil-mode 1))

(provide 'spartan-evil)
