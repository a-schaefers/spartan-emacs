;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; startup

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

;; generate spartan configuration file

(setq spartan-config (concat user-emacs-directory "spartan.el"))

(or (file-exists-p spartan-config)
    (progn
      (with-temp-file spartan-config
        (insert ";; CONFIG

;; Choose between holy or evil, and ido or ivy
(setq spartan-evil-or-holy \"holy\"
      spartan-ido-or-ivy \"ido\")

;; Font selection and size
(set-face-attribute 'default nil :family \"Monospace\" :height 120)

;; Appearance
(with-eval-after-load 'spartan-theme
  (spartan-install-themes
    ;; Add as many themes to install as you'd like here
    github-theme
    ;; spacemacs-theme
    ;; doom-themes
    )
  (load-theme spartan-load-theme t))

(setq ;; Set the precise theme name / variant to load here
 spartan-load-theme 'github ;;

 ;; Convert *scratch* buffer to persist between sessions, and make it un-killable (killing it drops it to the bottom of the stack.)
 spartan-persistent-scratch t

 ;; Use a simple, minimal mode, which only shows modified/unmodified state, the file name, the line number and the Major mode of the buffer.
 spartan-minimal-modeline t)

;; layers

(setq spartan-layers '(
                       ;; UI/UX
                       spartan-better-defaults
                       spartan-binds
                       spartan-theme
                       spartan-dashboard
                       spartan-ido-or-ivy
                       spartan-flymake
                       spartan-kill-ring
                       spartan-crux
                       spartan-evil-or-holy

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
                       ;; spartan-haskell
                       ;; spartan-javascript
                       ;; spartan-nix
                       ;; spartan-python
                       ;; spartan-ruby
                       ;; spartan-rust
                       ;; spartan-terraform
                       ))
"))))

(load-file spartan-config)

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
