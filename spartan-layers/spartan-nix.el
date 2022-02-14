;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(add-to-list 'spartan-package-list 'nix-mode)

(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))

(provide 'spartan-nix)
