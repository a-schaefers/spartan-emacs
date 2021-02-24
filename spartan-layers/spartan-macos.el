;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; for systems that don't inherit environment variables from a shell
;; gnome users might find this helpful, too.

(add-to-list 'spartan-package-list 'exec-path-from-shell)

(defun spartan-macos-hook ()
  (exec-path-from-shell-initialize))

(add-hook 'after-init-hook 'spartan-macos-hook)

(provide 'spartan-macos)
