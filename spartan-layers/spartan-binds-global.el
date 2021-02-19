;;; -*- lexical-binding: t; -*-

(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))
(global-unset-key (kbd "M-m"))

(with-eval-after-load 'spartan-collect-defun
  (global-set-key (kbd "C-%") 'forward-or-backward-sexp)) ; jump to matching bracket ala vim

(with-eval-after-load 'crux
  (global-set-key (kbd "C-a") 'crux-move-beginning-of-line)
  (global-set-key (kbd "C-o") 'crux-smart-open-line)
  (global-set-key (kbd "C-c C-l") 'crux-duplicate-current-line-or-region)
  (global-set-key (kbd "C-c C--") 'crux-kill-whole-line)
  (global-set-key (kbd "C-c ;") 'crux-duplicate-and-comment-current-line-or-region))

(with-eval-after-load 'browse-kill-ring
  (defalias 'kr 'browse-kill-ring)
  (global-set-key (kbd "M-y") 'browse-kill-ring))

(with-eval-after-load 'spartan-collect-defun
  (global-set-key (kbd "C-=") #'(lambda ()
                                  (interactive)
                                  (spartan-font-resizer 1)))
  (global-set-key (kbd "C--") #'(lambda ()
                                  (interactive)
                                  (spartan-font-resizer -1))))

;; REGEXP search

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-forward-regexp)

;; FIND FILES

(defalias 'ff 'find-name-dired)
(global-set-key (kbd "C-c pf") 'find-name-dired) ; replace projectile muscle memory

;; GREP FILES

(defalias 'gf 'grep)
(setq grep-command "grep -Ern '' .")
(global-set-key (kbd "C-c psg") 'grep) ; replace projectile muscle memory

;; DIFF

(defalias 'ed 'ediff)
(global-set-key (kbd "C-c |") 'ediff)

;; GIT

(defalias 'git 'magit)
(setq magit-repository-directories '(("~/repos" . 1)))
(global-set-key (kbd "C-c g") 'magit)

;; LINTER

(with-eval-after-load 'flymake
  (defalias 'lint 'flymake-show-diagnostics-buffer)
  (global-set-key (kbd "C-c f") 'flymake-show-diagnostics-buffer))

;; TERMBIN

(with-eval-after-load 'spartan-collect-defun
  (defalias 'tb 'buffer-to-termbin)
  (defalias 'tr 'region-to-termbin)
  (global-set-key (kbd "C-c t r") 'region-to-termbin)
  (global-set-key (kbd "C-c t b") 'buffer-to-termbin))

;; DUMB TERM

(with-eval-after-load 'better-shell
  (defalias 'sh 'better-shell-for-current-dir)
  (global-set-key (kbd "C-c $") 'better-shell-for-current-dir))

(provide 'spartan-binds-global)