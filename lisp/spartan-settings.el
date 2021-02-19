;;; -*- lexical-binding: t; -*-

(setq-default gc-cons-threshold 100000000
              read-process-output-max (* 1024 1024)
              custom-file "/dev/null"
              initial-major-mode 'emacs-lisp-mode
              inhibit-startup-screen nil
              load-prefer-newer t
              comp-deferred-compilation t
              package-native-compile t
              frame-resize-pixelwise t
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
              backup-directory-alist
              `((".*" . ,temporary-file-directory))
              auto-save-file-name-transforms
              `((".*" ,temporary-file-directory t))
              tab-always-indent 'complete
              tramp-default-method "ssh"
              tramp-copy-size-limit nil
              tramp-use-ssh-controlmaster-options nil
              ;; tramp-default-remote-shell "/bin/bash"
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

(fset 'yes-or-no-p 'y-or-n-p)

(provide 'spartan-settings)
