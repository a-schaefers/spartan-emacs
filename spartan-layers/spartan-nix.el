;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; usage: https://github.com/NixOS/nix-mode

(use-package nix-mode
  :straight t
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode)))

(provide 'spartan-nix)
