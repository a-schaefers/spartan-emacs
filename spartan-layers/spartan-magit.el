;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(use-package magit
  :straight t
  :defer t
  :init (defalias 'git 'magit))

(provide 'spartan-magit)
