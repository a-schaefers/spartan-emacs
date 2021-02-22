;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(add-to-list 'spartan-package-list 'browse-kill-ring)

(defun spartan-kill-ring-hook ()
  (require 'browse-kill-ring))

(add-hook 'after-init-hook 'spartan-kill-ring-hook)

(provide 'spartan-kill-ring)
