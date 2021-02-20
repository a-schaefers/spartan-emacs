;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; ███████╗██████╗;;█████╗;██████╗;████████╗;█████╗;
;; ██╔════╝██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗
;; ███████╗██████╔╝███████║██████╔╝;;;██║;;;███████║
;; ╚════██║██╔═══╝;██╔══██║██╔══██╗;;;██║;;;██╔══██║
;; ███████║██║;;;;;██║;;██║██║;;██║;;;██║;;;██║;;██║
;; ╚══════╝╚═╝;;;;;╚═╝;;╚═╝╚═╝;;╚═╝;;;╚═╝;;;╚═╝;;╚═╝
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; configuration

(defvar spartan-package-list '())

(defvar spartan-layers '(spartan-settings
                         spartan-theme
                         spartan-builtins
                         spartan-collect-defun
                         spartan-vetted
                         spartan-macos
                         spartan-elpa-melpa
                         spartan-binds-global
                         spartan-magit
                         spartan-eglot
                         ;; spartan-evil
                         spartan-lisp
                         spartan-bash
                         spartan-python))

;; startup

(setq-default gc-cons-threshold 100000000
              read-process-output-max (* 1024 1024)
              custom-file "/dev/null"
              inhibit-startup-screen nil
              initial-major-mode 'emacs-lisp-mode
              load-prefer-newer t
              comp-deferred-compilation t
              package-native-compile t)

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


;; spartan-layers

(add-to-list 'load-path (concat user-emacs-directory "spartan-layers"))

(dolist (layer spartan-layers)
  (require layer))

;; spartan.d/

(defvar spartan-lisp-d (concat user-emacs-directory "spartan.d"))

(when (file-directory-p spartan-lisp-d)
  (dolist (file (directory-files spartan-lisp-d nil "^.*\.el$"))
    (load-file (concat spartan-lisp-d "/" file))))

;;; init.el ends here
