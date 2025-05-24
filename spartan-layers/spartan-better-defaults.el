;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; utf-8 everywhere
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(global-eldoc-mode 1) ; eglot uses this too

(electric-pair-mode 1) ; auto parens in pairs

(add-hook 'before-save-hook 'whitespace-cleanup) ; auto strip whitespace

(delete-selection-mode) ; allow highlight and backspace over text like a normal editor

(setq-default
 frame-resize-pixelwise t ; support better certain window managers like ratpoison

 ;; better security
 gnutls-verify-error t
 gnutls-min-prime-bits 2048

 ;; dont expire a passphrase
 password-cache-expiry nil

 mouse-yank-at-point t
 save-interprogram-paste-before-kill t
 apropos-do-all t
 require-final-newline t
 ediff-window-setup-function 'ediff-setup-windows-plain

 tramp-default-method "ssh"
 tramp-copy-size-limit nil

 vc-follow-symlinks t ; open symlinks, don't ask confusing questions

 ring-bell-function 'ignore ; be quiet

 browse-url-browser-function 'eww-browse-url ; use a text browser --great for clicking documentation links
 )

(setq backup-directory-alist
       `((".*" . ,temporary-file-directory)))
 (setq auto-save-file-name-transforms
       `((".*" ,temporary-file-directory t)))

(defalias 'yes-or-no-p 'y-or-n-p) ; don't make us spell "yes" or "no"

;; better dired
(add-hook 'dired-load-hook (function (lambda () (load "dired-x"))))

;; M-x customize
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load-file custom-file))

(global-set-key (kbd "C-c i") #'(lambda ()
				  (interactive)
				  (find-file spartan-config)))

;; TAB is indent or auto completion
(setq tab-always-indent 'complete)

;; scrolling line by line
(setq scroll-conservatively most-positive-fixnum)

;; UNBIND ANNOYANCES
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))

;; nicer scrolling
(when (>=  emacs-major-version 29)
  (pixel-scroll-precision-mode 1))

(or (display-graphic-p)
    (progn
      (xterm-mouse-mode 1)))

(provide 'spartan-better-defaults)
