;;; -*- lexical-binding: t; -*-

(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "<f6>") 'spartan-shell-mode-compile)

;; https://github.com/joaotavora/eglot

(global-set-key (kbd "M-m e") 'eglot)

(with-eval-after-load 'eglot
  (define-key eglot-mode-map (kbd "M-m dd") 'eldoc)
  (define-key eglot-mode-map (kbd "M-,") 'eglot-rename)
  (define-key eglot-mode-map (kbd "M-=") 'eglot-format)
  (define-key eglot-mode-map (kbd "M-?") 'xref-find-references)
  (define-key eglot-mode-map (kbd "M-.") 'xref-find-definitions)
  (define-key eglot-mode-map (kbd "M-/") 'completion-at-point))

(provide 'spartan-prog-global)
