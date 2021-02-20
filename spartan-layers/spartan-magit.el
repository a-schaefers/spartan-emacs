;;; -*- lexical-binding: t; -*-

(add-to-list 'spartan-package-list 'magit)

(with-eval-after-load 'magit
  (setq magit-repository-directories '(("~/repos" . 1)))
  (setq magit-completing-read-function 'magit-ido-completing-read))

(provide 'spartan-magit)
