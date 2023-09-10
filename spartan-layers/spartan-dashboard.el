;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(use-package dashboard
  :straight t
  :defer t
  :init
  (dashboard-setup-startup-hook))

(provide 'spartan-dashboard)
