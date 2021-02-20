;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; for systems that don't inherit environment variables from a shell

(defun spartan-macos-hook ()
  (exec-path-from-shell-initialize))

(when (or (string= (getenv "XDG_CURRENT_DESKTOP") "gnome")
          (string= system-type "darwin"))
  (add-to-list 'spartan-package-list 'exec-path-from-shell)
  (add-hook 'after-init-hook 'spartan-macos-hook))

(provide 'spartan-macos)
