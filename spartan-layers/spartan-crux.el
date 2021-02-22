;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(add-to-list 'spartan-package-list 'crux)

(defun spartan-crux-hook ()
  (require 'crux))

(add-hook 'after-init-hook 'spartan-crux-hook)

(provide 'spartan-crux)
