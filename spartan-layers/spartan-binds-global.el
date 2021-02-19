;;; -*- lexical-binding: t; -*-

(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))
(global-unset-key (kbd "M-m"))


(global-set-key (kbd "C-c i") #'(lambda ()
                                  (interactive)
                                  (find-file user-init-file)))

(global-set-key (kbd "C-%") 'forward-or-backward-sexp) ; jump to matching bracket ala vim
(global-set-key (kbd "C-a") 'crux-move-beginning-of-line)
(global-set-key (kbd "C-o") 'crux-smart-open-line)
(global-set-key (kbd "C-c C-l") 'crux-duplicate-current-line-or-region)
(global-set-key (kbd "C-c C--") 'crux-kill-whole-line)
(global-set-key (kbd "C-c ;") 'crux-duplicate-and-comment-current-line-or-region)
(global-set-key (kbd "M-y") 'browse-kill-ring)

(global-set-key (kbd "C-x C-o") 'spacemacs/alternate-window)
(global-set-key (kbd "C-x C-b") 'spacemacs/alternate-buffer)
(global-set-key (kbd "C-x <C-backspace>") 'bury-buffer)

(global-set-key (kbd "C-=") #'(lambda ()
                     (interactive)
                     (spartan-font-resizer 1)))
(global-set-key (kbd "C--") #'(lambda ()
                     (interactive)
                     (spartan-font-resizer -1)))

;; REGEXP search

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-forward-regexp)

;; FIND FILES

(global-set-key (kbd "C-c pf") 'find-name-dired) ; replace projectile muscle memory

;; GREP FILES

(setq grep-command "grep -Ern '' .")
(global-set-key (kbd "C-c psg") 'grep) ; replace projectile muscle memory

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

(provide 'spartan-binds-global)
