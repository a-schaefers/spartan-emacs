;;; -*- lexical-binding: t; -*-

(add-to-list 'spartan-package-list 'projectile)

(defun spartan-projectile-hook ()
  (with-eval-after-load 'projectile
    ;; https://emacs.stackexchange.com/questions/32634/how-can-the-list-of-projects-used-by-projectile-be-manually-updated
    (when (require 'magit nil t)
      (mapc #'projectile-add-known-project
            (mapcar #'file-name-as-directory (magit-list-repos)))
      ;; Optionally write to persistent `projectile-known-projects-file'
      (projectile-save-known-projects)))

  (projectile-mode 1)

  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(add-hook 'after-init-hook 'spartan-projectile-hook)

(provide 'spartan-projectile)
