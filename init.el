;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; ███████╗██████╗;;█████╗;██████╗;████████╗;█████╗;
;; ██╔════╝██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗
;; ███████╗██████╔╝███████║██████╔╝;;;██║;;;███████║
;; ╚════██║██╔═══╝;██╔══██║██╔══██╗;;;██║;;;██╔══██║
;; ███████║██║;;;;;██║;;██║██║;;██║;;;██║;;;██║;;██║
;; ╚══════╝╚═╝;;;;;╚═╝;;╚═╝╚═╝;;╚═╝;;;╚═╝;;;╚═╝;;╚═╝
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq spartan-package-list '(magit eglot)
      spartan-lisp-d (concat user-emacs-directory "spartan.d")
      gc-cons-threshold 100000000
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
                                     (server-start))))

(add-to-list 'load-path "~/.emacs.d/spartan-lisp")
(add-to-list 'load-path "~/.emacs.d/spartan-lisp-vetted")

(require 'spartan-settings)
(require 'spartan-theme)
(require 'spartan-builtins)
(require 'spartan-collect-defun)
(require 'spartan-vetted)
(require 'spartan-macos)
(require 'spartan-elpa-melpa)
(require 'spartan-binds-global)
(require 'spartan-prog-global)
(require 'spartan-c)
(require 'spartan-lisp)
(require 'spartan-bash)
(require 'spartan-python)

(when (file-directory-p spartan-lisp-d)
  (dolist (file (directory-files spartan-lisp-d nil "^.*\.el$"))
    (load-file (concat spartan-lisp-d "/" file))))

;;; init.el ends here
