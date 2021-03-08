;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; `shell' is the preferred spartan-emacs shell because eshell and ansi/multi/term are all too buggy.
;; `shell' is a bash process attached to a buffer, so it has all of Emacs bindings, etc. That's perfect.

;; If you really need ncurses, you're probably doing it wrong.
;; But the best bet is to install libvterm and enable the vterm layer.
;; M-x vterm is for occasions when you can't get away from ncurses.

;; `shell-mode' SECTION

;; Greatly improve M-x `shell' by using `sh' aliased to `better-shell-for-current-dir'
(add-to-list 'spartan-package-list 'better-shell) ; https://github.com/killdash9/better-shell

;; SUPER helpful `shell' extensions
(add-to-list 'spartan-package-list 'shx)          ; https://github.com/riscy/shx-for-emacs

;; Add docker support to tramp
(add-to-list 'spartan-package-list 'docker-tramp)

;; Add shellcheck support to flymake (linter)
(when (executable-find "shellcheck") (add-to-list 'spartan-package-list 'flymake-shellcheck))

;; M-x `tramp'
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

;; auto chmod +x scripts
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; clickable jump to line of code from error output in shell mode
(add-hook 'shell-mode-hook 'compilation-shell-minor-mode)

;; <f6>
(defun spartan-script-execute()
  "Save a buffer and execute the script"
  (interactive)
  (save-buffer)
  (async-shell-command (buffer-file-name)))

;; turn it all on
(defun spartan-shell-hook ()
  (require 'shx)
  (require 'better-shell)

  (shx-global-mode 1))

(add-hook 'after-init-hook 'spartan-shell-hook)

;; bash section

;; bash everywhere because this is __GNU__ Emacs after all...
(setq tramp-default-remote-shell "/bin/bash"
      shell-file-name "/bin/bash"
      explicit-shell-file-name "/bin/bash")

;; sh/bash linter
(defun spartan-bash-hook ()
  (or
   ;; prefer shellcheck
   (when (executable-find "shellcheck")
     (require 'flymake-shellcheck)
     (setq flymake-shellcheck-use-file nil)
     (add-hook 'sh-mode-hook 'flymake-shellcheck-load))

   ;; fallback to bash-language-server
   (when (executable-find "bash-language-server")
     (with-eval-after-load 'eglot
	  (add-hook 'sh-mode-hook 'eglot-ensure)))))

(add-hook 'after-init-hook 'spartan-bash-hook)

(provide 'spartan-shell)
