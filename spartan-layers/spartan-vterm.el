;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; requires libvterm

(add-to-list 'spartan-package-list 'vterm)

(defun spartan-vterm-hook ()
  (require 'vterm))

(add-hook 'after-init-hook 'spartan-vterm-hook)

(provide 'spartan-vterm)
