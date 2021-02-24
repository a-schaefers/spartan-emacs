;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(add-to-list 'spartan-package-list 'dashboard)

(defun spartan-dashboard-hook ()

  (with-eval-after-load 'spartan-startup
    (setq inhibit-startup-screen t))

  (require 'dashboard)

  (dashboard-setup-startup-hook)

  (setq dashboard-startup-banner 'logo)

  (setq dashboard-banner-logo-title nil)

  (setq dashboard-center-content t)

  (setq dashboard-page-separator "\n\n")

  (setq dashboard-items '((recents  . 5)))

  (setq dashboard-set-init-info t)

  ;; (setq dashboard-init-info "sparta")

  (setq dashboard-footer-messages '("\"So that we may always have something to offer\""))

  ;; (with-eval-after-load 'projectile
  ;;   (add-to-list 'dashboard-items '(projects  . 5)))
  )

(add-hook 'after-init-hook 'spartan-dashboard-hook)

(provide 'spartan-dashboard)
