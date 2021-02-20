;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(add-to-list 'spartan-package-list 'eglot)

;; https://github.com/joaotavora/eglot

(defun spartan-eglot-hook ()
  (require 'eglot)
  (define-key eglot-mode-map (kbd "M-m dd") 'eldoc)
  (define-key eglot-mode-map (kbd "M-,") 'eglot-rename)
  (define-key eglot-mode-map (kbd "M-=") 'eglot-format)
  (define-key eglot-mode-map (kbd "M-?") 'xref-find-references)
  (define-key eglot-mode-map (kbd "M-.") 'xref-find-definitions)
  (define-key eglot-mode-map (kbd "M-/") 'completion-at-point))

(add-hook 'after-init-hook 'spartan-eglot-hook)

(provide 'spartan-eglot)
