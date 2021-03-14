;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(add-to-list 'spartan-package-list 'persistent-scratch)

(defun immortal-scratch ()
  (if (eq (current-buffer) (get-buffer "*scratch*"))
      (progn (bury-buffer)
             nil)
  t))

(add-hook 'kill-buffer-query-functions 'immortal-scratch)

(defun spartan-persistent-scratch-hook ()
  (require 'persistent-scratch)
  (persistent-scratch-setup-default))

(add-hook 'after-init-hook 'spartan-persistent-scratch-hook)

(provide 'spartan-persistent-scratch)
