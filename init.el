;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; ███████╗██████╗;;█████╗;██████╗;████████╗;█████╗;
;; ██╔════╝██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗
;; ███████╗██████╔╝███████║██████╔╝;;;██║;;;███████║
;; ╚════██║██╔═══╝;██╔══██║██╔══██╗;;;██║;;;██╔══██║
;; ███████║██║;;;;;██║;;██║██║;;██║;;;██║;;;██║;;██║
;; ╚══════╝╚═╝;;;;;╚═╝;;╚═╝╚═╝;;╚═╝;;;╚═╝;;;╚═╝;;╚═╝
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/vetted")

(require 'spartan-settings)
(require 'spartan-theme)
(require 'spartan-builtins)
(require 'spartan-collect-defun)
(require 'spartan-binds-global)

;; PKGS VETTED

(require 'paredit)
(require 'flymake-shellcheck)
(require 'docker-tramp)
(require 'browse-kill-ring)
(require 'crux)
(require 'better-shell)
(require 'shx)

;; PKGS ELPA/MELPA-STABLE

(require 'spartan-elpa-melpa)

;; CODE

(require 'spartan-prog-global)
(require 'spartan-c)
(require 'spartan-lisp)
(require 'spartan-bash)
(require 'spartan-python)

;;; init.el ends here
