;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(add-to-list 'spartan-package-list 'magit)

(defun spartan-magit-hook ()
  (require 'magit)
  (setq magit-repository-directories '(("~/repos" . 1)))
  (setq magit-completing-read-function 'magit-ido-completing-read))

(add-hook 'after-init-hook 'spartan-magit-hook)

(provide 'spartan-magit)
