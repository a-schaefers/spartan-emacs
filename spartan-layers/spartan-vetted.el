;;; -*- lexical-binding: t; -*-

(add-to-list 'load-path (concat user-emacs-directory "spartan-lisp-vetted"))

(require 'paredit)
(require 'flymake-shellcheck)
(require 'docker-tramp)
(require 'browse-kill-ring)
(require 'crux)
(require 'better-shell)
(require 'shx)
(require 'ido-completing-read+)
(require 'amx)
(require 'flx-ido)

(provide 'spartan-vetted)
