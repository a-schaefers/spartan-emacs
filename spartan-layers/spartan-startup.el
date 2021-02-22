;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(setq inhibit-startup-screen t
      initial-major-mode 'emacs-lisp-mode
      load-prefer-newer t)

(add-hook 'emacs-startup-hook #'(lambda ()
                                  (interactive)

                                  (require 'server)
                                  (or (server-running-p)
                                      (server-start))

                                  (find-file user-init-file)

                                  (message (concat "Welcome "
                                                   user-login-name
                                                   ", this is Sparta!"
                                                   " {}oo((X))ΞΞΞΞΞΞΞΞΞΞΞΞΞ>"))))

(provide 'spartan-startup)
