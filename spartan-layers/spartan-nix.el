;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; usage: https://github.com/NixOS/nix-mode

(use-package nix-mode
  :straight t
  :demand t
  :config
  (add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode)))

(provide 'spartan-nix)
