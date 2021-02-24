;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(add-to-list 'spartan-package-list 'dashboard)

(defun spartan-dashboard-hook ()

  (with-eval-after-load 'spartan-startup
    (setq inhibit-startup-screen t))

  (require 'dashboard)

  (setq dashboard-center-content t)

  (dashboard-setup-startup-hook)

  (setq dashboard-startup-banner 'logo)

  (setq dashboard-banner-logo-title nil)

  (setq dashboard-page-separator "\n\n")

  (setq dashboard-items '((recents  . 5)))

  (setq dashboard-set-init-info t)

  (with-eval-after-load 'projectile
    (add-to-list 'dashboard-items '(projects  . 5)))

  (setq dashboard-footer-messages '("\"So that we may always have something to offer\"")))

(add-hook 'after-init-hook 'spartan-dashboard-hook)

(provide 'spartan-dashboard)
