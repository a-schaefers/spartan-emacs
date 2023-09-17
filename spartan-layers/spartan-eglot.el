;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(use-package yasnippet
  :straight t
  :defer t
  :hook (prog-mode-hook . yas-minor-mode))

(use-package eglot
  :after yasnippet
  :straight t
  :defer t)

(with-eval-after-load 'eglot
          (define-key eglot-mode-map (kbd "M-m r") 'eglot-rename)
          (define-key eglot-mode-map (kbd "M-m o") 'eglot-code-action-organize-imports)
          (define-key eglot-mode-map (kbd "M-m h") 'eldoc)
          (define-key eglot-mode-map (kbd "M-m =") 'eglot-format)
          (define-key eglot-mode-map (kbd "M-m ?") 'xref-find-references)
          (define-key eglot-mode-map (kbd "M-.") 'xref-find-definitions))

(provide 'spartan-eglot)
