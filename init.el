;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; configuration -- comment or uncomment desired layers => C-x C-s => M-x spartan-reconfigure

(setq spartan-layers '(
                       ;; UI/UX
                       spartan-better-defaults
                       spartan-binds
                       spartan-theme
                       spartan-ido
                       spartan-flymake
                       spartan-kill-ring
                       spartan-crux
                       ;;spartan-evil

                       ;; IDE-LIKE FEATURES
                       spartan-projectile
                       spartan-magit
                       spartan-eglot
                       spartan-company

                       ;; LANGUAGE SUPPORT
                       spartan-bash
                       spartan-c
                       spartan-elisp
                       ;; spartan-go
                       ;; spartan-javascript
                       ;; spartan-nix
                       ;; spartan-python
                       ;; spartan-ruby
                       ;; spartan-rust
                       ;; spartan-terraform
                       ))

;; Startup

(setq package-enable-at-startup nil
      load-prefer-newer t
      inhibit-startup-screen t
      initial-major-mode 'emacs-lisp-mode)

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

;; Performance

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

;; spartan-layers

(add-to-list 'load-path (concat user-emacs-directory "spartan-layers"))

(dolist (layer spartan-layers)
  (require layer))

;; spartan.d/

(setq spartan-lisp-d (concat user-emacs-directory "spartan.d"))
(or
 (file-directory-p spartan-lisp-d)
 (make-directory spartan-lisp-d))

(defun spartan-user-local-hook ()
  (when (file-directory-p spartan-lisp-d)
    (dolist (file (directory-files spartan-lisp-d nil "^.*\.el$"))
      (load-file (concat spartan-lisp-d "/" file)))))

(add-hook 'emacs-startup-hook 'spartan-user-local-hook)

;; M-x spartan-reconfigure

(defun spartan-reconfigure ()
  (interactive)
  (load-file user-init-file)
  (run-hooks 'after-init-hook
             'emacs-startup-hook))

;;; init.el ends here
