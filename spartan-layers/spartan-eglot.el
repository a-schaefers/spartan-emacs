;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(use-package yasnippet
  :straight t
  :defer t
  :hook (prog-mode-hook . yas-minor-mode))

(use-package eglot
  :after yasnippet
  :straight t
  :defer t
  :config
  (define-key eglot-mode-map (kbd "M-m dd") 'eldoc)
  (define-key eglot-mode-map (kbd "M-m ,") 'eglot-rename)
  (define-key eglot-mode-map (kbd "M-m o") 'eglot-code-action-organize-imports)
  (define-key eglot-mode-map (kbd "M-=") 'eglot-format)
  (define-key eglot-mode-map (kbd "M-?") 'xref-find-references)
  (define-key eglot-mode-map (kbd "M-.") 'xref-find-definitions)
  (define-key eglot-mode-map (kbd "M-/") 'completion-at-point))

(provide 'spartan-eglot)
