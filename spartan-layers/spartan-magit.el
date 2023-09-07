;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(use-package magit
  :straight t
  :demand t
  :config
  (setq magit-repository-directories '(("~/repos" . 1)))

  (defalias 'git 'magit))

(provide 'spartan-magit)
