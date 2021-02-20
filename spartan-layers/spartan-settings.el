;;; -*- lexical-binding: t; -*-

(setq-default frame-resize-pixelwise t ; support better certain window managers like ratpoison
              indent-tabs-mode nil
              tab-width 8
              fill-column 79
              gnutls-verify-error t
              gnutls-min-prime-bits 2048
              password-cache-expiry nil
              mouse-yank-at-point t
              save-interprogram-paste-before-kill t
              apropos-do-all t
              require-final-newline t
              ediff-window-setup-function 'ediff-setup-windows-plain
              backup-directory-alist `(("." . ,(concat user-emacs-directory "backups")))
              tab-always-indent 'complete

              tramp-default-method "ssh"
              tramp-copy-size-limit nil
              tramp-use-ssh-controlmaster-options nil

              ;; I recommend the following ~/.ssh/config settings be used with the tramp settings in this cfg:
              ;; Host *
              ;; ForwardAgent yes
              ;; AddKeysToAgent yes
              ;; ControlMaster auto
              ;; ControlPath ~/.ssh/master-%r@%h:%p
              ;; ControlPersist yes
              ;; ServerAliveInterval 10
              ;; ServerAliveCountMax 10

              tramp-default-remote-shell "/bin/bash"
              shell-file-name "/bin/bash"
              explicit-shell-file-name "/bin/bash"

              vc-follow-symlinks t
              ring-bell-function 'ignore
              browse-url-browser-function 'eww-browse-url
              ido-create-new-buffer 'always
              ido-auto-merge-work-directories-length -1
              ido-enable-flex-matching t
              ido-use-filename-at-point 'guess
              ido-use-faces nil)

(defalias 'yes-or-no-p 'y-or-n-p)

(with-eval-after-load 'ido-completing-read+
  (ido-ubiquitous-mode 1))

(with-eval-after-load 'amx
  (setq amx-ignored-command-matchers nil
        amx-show-key-bindings nil)
  (amx-mode 1))

(with-eval-after-load 'flx-ido
  (flx-ido-mode 1)
  (setq ido-enable-flex-matching t)
  (setq ido-use-faces nil))

(provide 'spartan-settings)
