;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(add-to-list 'spartan-package-list 'projectile)

(defun spartan-projectile-hook ()
  (require 'projectile)
  (projectile-mode 1)

  (with-eval-after-load 'magit
    ;; https://emacs.stackexchange.com/questions/32634/how-can-the-list-of-projects-used-by-projectile-be-manually-updated
    (mapc #'projectile-add-known-project
          (mapcar #'file-name-as-directory (magit-list-repos)))
    (projectile-save-known-projects)))

(add-hook 'after-init-hook 'spartan-projectile-hook)

(provide 'spartan-projectile)
