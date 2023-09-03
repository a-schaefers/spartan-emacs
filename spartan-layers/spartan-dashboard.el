;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(use-package dashboard
  :straight t
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(setq dashboard-startup-banner nil)
(setq dashboard-banner-logo-title "
 _______  _____  _______  ______ _______ _______
 |______ |_____] |_____| |_____/    |    |_____|
 ______| |       |     | |    \\_    |    |     |
")
(provide 'spartan-dashboard)
