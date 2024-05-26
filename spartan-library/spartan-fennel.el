;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(use-package fennel-mode
  :straight t
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.fnl\\'" . fennel-mode)))
