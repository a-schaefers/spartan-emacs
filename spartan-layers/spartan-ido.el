;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(use-package amx
  :straight t
  :demand t
  :config
  (setq amx-ignored-command-matchers nil
        amx-show-key-bindings nil)
  (amx-mode 1))

(use-package ido
  :straight t
  :demand t
  :config
  (setq ido-create-new-buffer 'always
        ido-auto-merge-work-directories-length -1
        ido-enable-flex-matching t
        ido-use-filename-at-point 'guess
        ido-use-faces nil)

  (ido-mode 1)
  (ido-everywhere 1))

(use-package ido-completing-read+
  :straight t
  :demand t
  :config
  (ido-ubiquitous-mode 1))

(provide 'spartan-ido)
