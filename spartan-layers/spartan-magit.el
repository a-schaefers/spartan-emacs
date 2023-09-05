;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(use-package magit
  :straight t
  :demand t
  :config
  (setq magit-repository-directories '(("~/repos" . 1)))

  (unless (or (fboundp 'helm-mode)
              (fboundp 'ivy-mode))
    (setq magit-completing-read-function 'magit-ido-completing-read))

  (defalias 'git 'magit))

(provide 'spartan-magit)
