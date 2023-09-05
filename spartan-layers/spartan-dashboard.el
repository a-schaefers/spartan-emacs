;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(use-package dashboard
  :straight t
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(provide 'spartan-dashboard)
