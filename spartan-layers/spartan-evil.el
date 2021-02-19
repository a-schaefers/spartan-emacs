;;; -*- lexical-binding: t; -*-

(add-to-list 'spartan-package-list 'evil)

(defun spartan-evil-hook ()
  (require 'evil)
  (evil-mode 1))

(add-hook 'window-setup-hook 'spartan-evil-hook)

(provide 'spartan-evil)
