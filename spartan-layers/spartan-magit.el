;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(use-package magit
  :straight t
  :defer t
  :init (defalias 'git 'magit)
  (setq magit-repository-directories '((spartan-projects . 1))))

(provide 'spartan-magit)
