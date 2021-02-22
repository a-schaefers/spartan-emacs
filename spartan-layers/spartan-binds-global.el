;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))
(global-unset-key (kbd "M-m"))

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-/") 'hippie-expand)

(defun forward-or-backward-sexp (&optional arg)
  "Go to the matching parenthesis character if one is adjacent to point."
  (interactive "^p")
  (cond ((looking-at "\\s(") (forward-sexp arg))
        ((looking-back "\\s)" 1) (backward-sexp arg))
        ;; Now, try to succeed from inside of a bracket
        ((looking-at "\\s)") (forward-char) (backward-sexp arg))
        ((looking-back "\\s(" 1) (backward-char) (forward-sexp arg))))

(global-set-key (kbd "C-%") 'forward-or-backward-sexp)

(with-eval-after-load 'crux
  (global-set-key (kbd "C-a") 'crux-move-beginning-of-line)
  (global-set-key (kbd "C-o") 'crux-smart-open-line)
  (global-set-key (kbd "C-c C-l") 'crux-duplicate-current-line-or-region)
  (global-set-key (kbd "C-c C--") 'crux-kill-whole-line)
  (global-set-key (kbd "C-c ;") 'crux-duplicate-and-comment-current-line-or-region))

(with-eval-after-load 'browse-kill-ring
  (defalias 'kr 'browse-kill-ring)
  (global-set-key (kbd "M-y") 'browse-kill-ring))

(with-eval-after-load 'spartan-theme
  (global-set-key (kbd "C-=") #'(lambda ()
                                  (interactive)
                                  (spartan-font-resizer 1)))
  (global-set-key (kbd "C--") #'(lambda ()
                                  (interactive)
                                  (spartan-font-resizer -1))))

;; REGEXP search

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)

;; FIND FILES

(defalias 'ff 'find-name-dired)
(global-set-key (kbd "C-c pf") 'find-name-dired) ; replace projectile muscle memory

;; GREP FILES

(defalias 'rg 'rgrep)
(global-set-key (kbd "C-c psg") 'rgrep) ; replace projectile muscle memory

;; DIFF

(defalias 'ed 'ediff)
(global-set-key (kbd "C-c |") 'ediff)

;; GIT

(with-eval-after-load 'magit
  (defalias 'git 'magit)
  (global-set-key (kbd "C-c g") 'magit))

;; LINTER

(with-eval-after-load 'flymake
  (defalias 'lint 'flymake-show-diagnostics-buffer)
  (global-set-key (kbd "C-c f") 'flymake-show-diagnostics-buffer))

;; TERMBIN

(with-eval-after-load 'webpaste
  (defalias 'pb 'webpaste-paste-buffer-or-region)
  (global-set-key (kbd "C-c C-p C-p") 'webpaste-paste-buffer-or-region))

;; DUMB TERM

(with-eval-after-load 'better-shell
  (defalias 'sh 'better-shell-for-current-dir)
  (global-set-key (kbd "C-c $") 'better-shell-for-current-dir))

;; COMPILE COMMAND / EXECUTE SCRIPT

(setq compile-command "make -k ")
(global-set-key (kbd "<f5>") 'compile)

(with-eval-after-load 'spartan-shell
  (global-set-key (kbd "<f6>") 'spartan-script-execute))

(provide 'spartan-binds-global)
