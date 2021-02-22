;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(add-to-list 'spartan-package-list 'better-shell)
(add-to-list 'spartan-package-list 'shx)

(defun spartan-script-execute()
  (interactive)
  (save-buffer)
  (async-shell-command (buffer-file-name)))

(defun spartan-shell-hook ()
  (require 'shx)
  (require 'better-shell))

(add-hook 'after-init-hook 'spartan-shell-hook)

(provide 'spartan-shell)
