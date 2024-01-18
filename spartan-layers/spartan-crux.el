;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(use-package crux
  :straight t
  :defer t
  :init
  (global-set-key (kbd "C-a") 'crux-move-beginning-of-line)
  (global-set-key (kbd "C-x ;") 'comment-line) ; "C-x C-;" is interpreted this way in some terminals
  (global-set-key (kbd "C-o") 'crux-smart-open-line)

  (global-set-key (kbd "C-x C-o") 'crux-other-window-or-switch-buffer)
  (global-set-key (kbd "C-c C-o") 'crux-other-window-or-switch-buffer)

  (global-set-key (kbd "C-c C-l") 'crux-duplicate-current-line-or-region)
  (global-set-key (kbd "C-c l") 'crux-duplicate-current-line-or-region)

  (global-set-key (kbd "C-c -") 'crux-kill-whole-line)
  (global-set-key (kbd "C-c C--") 'crux-kill-whole-line)

  (global-set-key (kbd "C-c ;") 'crux-duplicate-and-comment-current-line-or-region))

(provide 'spartan-crux)
