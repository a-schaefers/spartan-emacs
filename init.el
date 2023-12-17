;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; startup

(setq package-enable-at-startup nil
      load-prefer-newer t
      inhibit-startup-screen t)

(add-hook 'after-init-hook #'(lambda ()
                               (interactive)
                               (require 'server)
                               (or (server-running-p)
                                   (server-start))))

;; straight+use-package

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(setq use-package-compute-statistics t)

;; performance

;; https://emacs-lsp.github.io/lsp-mode/page/performance/
(setq gc-cons-threshold 100000000
      read-process-output-max (* 1024 1024))

;; https://www.masteringemacs.org/article/speed-up-emacs-libjansson-native-elisp-compilation
(if (and (fboundp 'native-comp-available-p)
         (native-comp-available-p))
    (setq comp-deferred-compilation t
          package-native-compile t)
  (message "Native complation is *not* available, lsp performance will suffer..."))

(unless (functionp 'json-serialize)
  (message "Native JSON is *not* available, lsp performance will suffer..."))

;; do not steal focus while doing async compilations
(setq warning-suppress-types '((comp)))

;; generate spartan configuration file

(setq spartan-config (concat user-emacs-directory "spartan.el"))

(or (file-exists-p spartan-config)
    (progn
      (with-temp-file spartan-config
        (insert ";; Spartan.el Emacs General Settings

(setq spartan-evil-or-holy \"holy\"   ; choose holy or evil
      spartan-persistent-scratch t  ; t or nil
      spartan-minimal-modeline t    ; t or nil
      spartan-preferred-shell \"bash\" ; must be available on PATH
      magit-repository-directories '((\"~/repos\" . 1)) ; where your projects live
      initial-major-mode 'fundamental-mode
      initial-scratch-message \"This is a persistent, unkillable scratch pad, stored to ~/.emacs.d/scratch\")

;; Font settings

(set-face-attribute 'default nil :family \"Monospace\" :height 120)

;; Theme customization settings

(with-eval-after-load 'spartan-theme
  (spartan-install-themes
    ;; Add as many themes to install as you'd like here
    github-theme
    dracula-theme
    spacemacs-theme
    doom-themes
    )

  ;; Load specific theme variant by modifying here
  (load-theme 'spacemacs-dark t))

;; Transparency
;; (set-frame-parameter nil 'alpha-background 75) ; This frame
;; (add-to-list 'default-frame-alist '(alpha-background . 75)) ; New frames

;; Dashboard customization settings

(setq dashboard-startup-banner 'ascii)
(setq dashboard-banner-ascii \"

   ▄████████   ▄▄▄▄███▄▄▄▄      ▄████████  ▄████████    ▄████████
  ███    ███ ▄██▀▀▀███▀▀▀██▄   ███    ███ ███    ███   ███    ███
  ███    █▀  ███   ███   ███   ███    ███ ███    █▀    ███    █▀
 ▄███▄▄▄     ███   ███   ███   ███    ███ ███          ███
▀▀███▀▀▀     ███   ███   ███ ▀███████████ ███        ▀███████████
  ███    █▄  ███   ███   ███   ███    ███ ███    █▄           ███
  ███    ███ ███   ███   ███   ███    ███ ███    ███    ▄█    ███
  ██████████  ▀█   ███   █▀    ███    █▀  ████████▀   ▄████████▀


\")
(setq dashboard-center-content t)
(setq dashboard-banner-logo-title \"Spartan edition\")
(and (file-exists-p spartan-first-time-run-has-completed)
     (setq dashboard-footer-messages '(\"Vincit qui se vincit.\")))

(setq dashboard-items '((recents  . 5)
                        ;; (bookmarks . 5)
                        ;; (projects . 5)
                        ;; (agenda . 5)
                        ;; (registers . 5)
                        ))

;; Layers

(setq spartan-layers '(
                       spartan-better-defaults
                       spartan-theme
                       spartan-dashboard
                       spartan-vertico
                       spartan-flymake
                       spartan-crux
                       spartan-evil-or-holy
                       spartan-magit
                       spartan-projectile
                       spartan-eglot
                       spartan-company
                       spartan-shell
                       spartan-c
                       ))

"))))

(setq spartan-first-time-run-has-completed (concat user-emacs-directory ".spartan-first-time-run-has-completed"))

(load-file spartan-config)

(or (file-exists-p spartan-first-time-run-has-completed)
    (progn
      ;; This code here executes only on the first-time startup of Spartan Emacs
      (setq dashboard-footer-messages '("Tip: Use 'C-c i' to view settings pertaining to Spartan Emacs configuration"))
      (with-temp-file spartan-first-time-run-has-completed (insert "Hello"))))

;; spartan-layers

(add-to-list 'load-path (concat user-emacs-directory "spartan-layers"))

(dolist (layer spartan-layers)
  (require layer))

;; spartan.d/ loads last

(setq spartan-lisp-d (concat user-emacs-directory "spartan.d"))
(or
 (file-directory-p spartan-lisp-d)
 (make-directory spartan-lisp-d))

(defun spartan-user-local-hook ()
  (when (file-directory-p spartan-lisp-d)
    (dolist (file (directory-files spartan-lisp-d nil "^.*\.el$"))
      (load-file (concat spartan-lisp-d "/" file)))))

(add-hook 'emacs-startup-hook 'spartan-user-local-hook)

;;; init.el ends here
