;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(add-to-list 'spartan-package-list 'webpaste)

(defun spartan-webpaste-hook ()
  (require 'webpaste))

(add-hook 'after-init-hook 'spartan-webpaste-hook)

(provide 'spartan-webpaste)
