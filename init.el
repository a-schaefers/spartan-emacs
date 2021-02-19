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
(require 'spartan-vetted)
(require 'spartan-elpa-melpa)
(require 'spartan-binds-global)
(require 'spartan-prog-global)
(require 'spartan-c)
(require 'spartan-lisp)
(require 'spartan-bash)
(require 'spartan-python)

;;; init.el ends here
