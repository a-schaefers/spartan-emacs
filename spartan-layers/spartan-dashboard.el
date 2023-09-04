;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(use-package dashboard
  :straight t
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(setq dashboard-startup-banner (concat user-emacs-directory "spartan-army-spear-royalty-free-spear.png"))
(setq dashboard-center-content t)
(setq dashboard-banner-logo-title "Spartan Emacs")

(setq dashboard-footer-messages '("Vincit qui se vincit."))

(or (file-exists-p (concat user-emacs-directory ".spartan-first-run"))
    (progn
      (setq dashboard-footer-messages '("Tip: Use 'C-c i' to view settings pertaining to Spartan Emacs configuration"))
      (with-temp-file (concat user-emacs-directory ".spartan-first-run") (insert "Hello World"))))


(setq dashboard-items '((recents  . 5)
                        ;; (bookmarks . 5)
                        ;; (projects . 5)
                        ;; (agenda . 5)
                        ;; (registers . 5)
                        ))

(provide 'spartan-dashboard)
