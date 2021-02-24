;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; for systems that don't inherit environment variables from a shell

(defun spartan-macos-hook ()
  (exec-path-from-shell-initialize))

(when (or (string= (getenv "XDG_CURRENT_DESKTOP") "gnome")
	  (string= system-type "darwin"))
  (add-to-list 'spartan-package-list 'exec-path-from-shell)
  (add-hook 'after-init-hook 'spartan-macos-hook))

;; clipboard support in a terminal
(and (string= system-type "darwin")
     (or window-system
	 (progn
	   (add-to-list 'spartan-package-list 'osx-clipboard)
	   (osx-clipboard-mode +1))))

(provide 'spartan-macos)
