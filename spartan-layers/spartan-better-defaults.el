;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; utf-8 everywhere
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(global-eldoc-mode 1) ; eglot uses this too

(winner-mode 1) ; C-c <left>, C-c <right> window layout undo/redo

(electric-pair-mode 1) ; auto parens in pairs

(delete-selection-mode) ; allow highlight and backspace over text like a normal editor

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p) ; auto chmod +x scripts

(add-hook 'before-save-hook 'whitespace-cleanup) ; auto strip whitespace

(recentf-mode 1) ; track recently opened files

(savehist-mode 1) ; save minibuffer history

(add-hook 'prog-mode-hook 'goto-address-mode) ; make comment urls clickable

;; clean look
(blink-cursor-mode -1)
(scroll-bar-mode -1)
(fringe-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

;; better dired
(add-hook 'dired-load-hook
	  (lambda ()
	    (load "dired-x")))

(setq frame-resize-pixelwise t ; support better certain window managers like ratpoison

      ;; these settings still should be set on a per language basis, this is just a general default
      indent-tabs-mode nil ; spaces > tabs
      tab-width 8 ; tab is 8 spaces
      fill-column 79 ; python friendly

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
      backup-directory-alist `(("." . ,(concat user-emacs-directory "backups")))

      ;; the most reliable tramp setup I have found (used at work every day...)
      tramp-default-method "ssh"
      tramp-copy-size-limit nil
      tramp-use-ssh-controlmaster-options nil

      ;; I recommend the following ~/.ssh/config settings be used with the tramp settings in this cfg:
      ;; Host *
      ;; ForwardAgent yes
      ;; AddKeysToAgent yes
      ;; ControlMaster auto
      ;; ControlPath ~/.ssh/master-%r@%h:%p
      ;; ControlPersist yes
      ;; ServerAliveInterval 10
      ;; ServerAliveCountMax 10

      ;; bash, please
      tramp-default-remote-shell "/bin/bash"
      shell-file-name "/bin/bash"
      explicit-shell-file-name "/bin/bash"


      vc-follow-symlinks t ; open symlinks, don't ask confusing questions

      ring-bell-function 'ignore ; be quiet

      browse-url-browser-function 'eww-browse-url ; use a text browser --great for clicking documentation links
      )

(defalias 'yes-or-no-p 'y-or-n-p) ; don't make us spell "yes" or "no"

(provide 'spartan-better-defaults)
