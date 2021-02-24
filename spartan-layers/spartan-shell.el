;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(add-to-list 'spartan-package-list 'better-shell)
(add-to-list 'spartan-package-list 'shx)
(add-to-list 'spartan-package-list 'docker-tramp)

(defun spartan-tramp (x)
  "Tramp using ssh or docker, optionally as root, and [optionally] store creds in .authinfo[.gpg] if Emacs 27
TIP: Try M-x sh after this, for a remote shell."
  (interactive "sServer name: ")
  (require 'ido)
  (let ((choices '("ssh" "docker")))
    (setq spartan-tramp-method (ido-completing-read "Tramp to:" choices))
    (if (yes-or-no-p "sudo to root? ")
	(find-file (concat "/" spartan-tramp-method ":" x "|sudo:" x ":"))
      (find-file (concat "/" spartan-tramp-method ":" x ":")))))

(defun spartan-script-execute()
  (interactive)
  (save-buffer)
  (async-shell-command (buffer-file-name)))

(defun spartan-shell-hook ()
  (require 'shx)
  (require 'better-shell)

  (shx-global-mode 1))

(add-hook 'after-init-hook 'spartan-shell-hook)

(provide 'spartan-shell)
