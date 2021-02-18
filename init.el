;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; update config `git pull`
;; update emacs `pikaur -Syu emacs-pgtk-native-comp-git`
;; update third party pkgs, M-x package-list-packages, then U followed by x

;; SETTINGS

(setq-default gc-cons-threshold 100000000
              read-process-output-max (* 1024 1024)
              custom-file "/dev/null"
              initial-major-mode 'emacs-lisp-mode
              inhibit-startup-screen nil
              load-prefer-newer t
              comp-deferred-compilation t
              package-native-compile t
              frame-resize-pixelwise t
              indent-tabs-mode nil
              tab-width 8
              fill-column 79
              gnutls-verify-error t
              gnutls-min-prime-bits 2048
              password-cache-expiry nil
              mouse-yank-at-point t
              save-interprogram-paste-before-kill t
              apropos-do-all t
              require-final-newline t
              ediff-window-setup-function 'ediff-setup-windows-plain
              backup-directory-alist
              `((".*" . ,temporary-file-directory))
              auto-save-file-name-transforms
              `((".*" ,temporary-file-directory t))
              tab-always-indent 'complete
              tramp-default-method "ssh"
              tramp-copy-size-limit nil
              tramp-use-ssh-controlmaster-options nil
              ;; tramp-default-remote-shell "/bin/bash"
              shell-file-name "/bin/bash"
              explicit-shell-file-name "/bin/bash"
              vc-follow-symlinks t
              ring-bell-function 'ignore
              browse-url-browser-function 'eww-browse-url
              ido-create-new-buffer 'always
              ido-auto-merge-work-directories-length -1
              ido-enable-flex-matching t
              ido-use-filename-at-point 'guess
              ido-use-faces nil)

(fset 'yes-or-no-p 'y-or-n-p)

;; BUILT-IN PKGS

(add-hook 'prog-mode-hook 'goto-address-mode)

(add-hook 'window-setup-hook #'(lambda ()
                                 (require 'server)
                                 (or (server-running-p)
                                     (server-start))))

(blink-cursor-mode 1)
(scroll-bar-mode -1)
(fringe-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(global-eldoc-mode 1)

(winner-mode 1)

(electric-pair-mode 1)

(delete-selection-mode)

(show-paren-mode 1)

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(add-hook 'before-save-hook 'whitespace-cleanup)

(save-place-mode 1)

(recentf-mode 1)

(savehist-mode 1)

(ido-mode 1)

(eval-after-load 'flymake
  (remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake))
(add-hook 'prog-mode-hook 'flymake-mode)

;; MANUALLY VETTED PKGS

(add-to-list 'load-path "~/.emacs.d/vetted/")
(require 'snippets)
(require 'flymake-shellcheck)
(require 'docker-tramp)
(require 'browse-kill-ring)
(require 'crux)

;; THIRD PARTY PKGS

(setq package-list '(
                     magit ;; pulls in dash, with-editor, transient

                     eglot ;; only requires Emacs.
                     ))

(require 'package)

;; Prefer GNU ELPA > MELPA [stable] (fallback)
(setq package-archives
      '(("GNU ELPA"     . "https://elpa.gnu.org/packages/")
        ("MELPA Stable" . "https://stable.melpa.org/packages/"))
      package-archive-priorities
      '(("GNU ELPA"     . 10)
        ("MELPA Stable" . 5)))

(setq package-enable-at-startup nil)

(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(require 'magit)
(require 'eglot)

(setq my-font "Source Code Pro"
      my-font-size '10)
(my-font-resizer 0)

;; BINDS

(global-set-key (kbd "C-c i") #'(lambda ()
                                  (interactive)
                                  (find-file user-init-file)))

(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))
(global-unset-key (kbd "M-m"))
(global-set-key (kbd "C-%") 'forward-or-backward-sexp)
(global-set-key (kbd "C-a") 'crux-move-beginning-of-line)
(global-set-key (kbd "C-o") 'crux-smart-open-line)
(global-set-key (kbd "C-c C-l") 'crux-duplicate-current-line-or-region)
(global-set-key (kbd "C-c C--") 'crux-kill-whole-line)
(global-set-key (kbd "C-c ;") 'crux-duplicate-and-comment-current-line-or-region)
(global-set-key (kbd "M-y") 'browse-kill-ring)
(global-set-key (kbd "C-x C-o") 'spacemacs/alternate-window)
(global-set-key (kbd "C-x C-b") 'spacemacs/alternate-buffer)
(global-set-key (kbd "C-x <C-backspace>") 'bury-buffer)
(global-set-key (kbd "C-1") 'delete-other-windows)
(global-set-key (kbd "C-2") 'split-window-below)
(global-set-key (kbd "C-3") 'split-window-right)
(global-set-key (kbd "C-0") 'delete-window)
(global-set-key (kbd "C-=") #'(lambda ()
                     (interactive)
                     (my-font-resizer 1)))
(global-set-key (kbd "C--") #'(lambda ()
                     (interactive)
                     (my-font-resizer -1)))

;; FIND FILE

(global-set-key (kbd "C-c pf") 'find-name-dired)

;; GREP FILE

(global-set-key (kbd "C-c psg") 'grep)

;; DIFF

(global-set-key (kbd "C-c |") 'ediff)

;; GIT

(setq magit-repository-directories '(("~/repos" . 1)))
(global-set-key (kbd "C-c g") 'magit-status)

;; LINTER

(global-set-key (kbd "C-c f") 'flymake-show-diagnostics-buffer)

;; PASTEBIN

(global-set-key (kbd "C-c t r") 'region-to-termbin)
(global-set-key (kbd "C-c t b") 'buffer-to-termbin)

;; ALL LANGUAGES

(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "<f6>") 'my-shell-mode-compile)

;; https://github.com/joaotavora/eglot

(global-set-key (kbd "M-m e") 'eglot)

(with-eval-after-load 'eglot
  (define-key eglot-mode-map (kbd "M-m dd") 'eldoc)
  (define-key eglot-mode-map (kbd "M-,") 'eglot-rename)
  (define-key eglot-mode-map (kbd "M-=") 'eglot-format)
  (define-key eglot-mode-map (kbd "M-?") 'xref-find-references)
  (define-key eglot-mode-map (kbd "M-.") 'xref-find-definitions)
  (define-key eglot-mode-map (kbd "M-/") 'completion-at-point))

;; C

(setq c-default-style "linux")
(add-hook 'c-mode-hook
          (lambda () (setq indent-tabs-mode t)))

;; EMACS LISP

(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-defun)
(define-key emacs-lisp-mode-map (kbd "C-c C-b") 'eval-buffer)

;; BASH

(setq flymake-shellcheck-use-file nil)
(add-hook 'sh-mode-hook 'flymake-shellcheck-load)

(global-set-key (kbd "C-c $") 'shell)

;; PYTHON

(add-hook 'python-mode-hook 'eglot-ensure)

(with-eval-after-load 'python
  (define-key python-mode-map (kbd "M-m rr") 'python-shell-send-region)
  (define-key python-mode-map (kbd "M-m rb") 'python-shell-send-buffer)
  (define-key python-mode-map (kbd "M-m rR") 'run-python)
  (define-key python-mode-map (kbd "M-m db") 'db))

;;; init.el ends here
