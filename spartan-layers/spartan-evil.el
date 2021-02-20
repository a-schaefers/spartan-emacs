;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(add-to-list 'spartan-package-list 'evil)

(defun spartan-evil-hook ()
  (require 'evil)
  (evil-mode 1))

(add-hook 'after-init-hook 'spartan-evil-hook)

(provide 'spartan-evil)
