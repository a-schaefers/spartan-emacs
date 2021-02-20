;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(setq inhibit-startup-screen nil
      initial-major-mode 'emacs-lisp-mode
      load-prefer-newer t)

(add-hook 'window-setup-hook #'(lambda ()
                                 (interactive)

                                 (require 'server)
                                 (or (server-running-p)
                                     (server-start))

                                 (message (concat "<ΞΞΞΞΞΞΞΞΞΞΞΞΞ((X))oo{} "
                                                  "Welcome "
                                                  user-login-name
                                                  ", this is Sparta!"
                                                  " {}oo((X))ΞΞΞΞΞΞΞΞΞΞΞΞΞ>"))))

(provide 'spartan-startup)
