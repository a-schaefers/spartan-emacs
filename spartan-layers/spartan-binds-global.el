;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; Unbind annoyances
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))
(global-unset-key (kbd "M-m"))

;; Tab auto completion
(setq tab-always-indent 'complete) ; used by eglot for auto-completion as well

;; Better-defaults
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

;; Ala vim
(global-set-key (kbd "C-%") 'forward-or-backward-sexp)

;; Collection of Rediculously useful eXtensions (requires spartan-crux layer)

(with-eval-after-load 'crux
  (global-set-key (kbd "C-a") 'crux-move-beginning-of-line)
  (global-set-key (kbd "C-o") 'crux-smart-open-line)
  (global-set-key (kbd "C-c C-l") 'crux-duplicate-current-line-or-region)
  (global-set-key (kbd "C-c C--") 'crux-kill-whole-line)
  (global-set-key (kbd "C-c ;") 'crux-duplicate-and-comment-current-line-or-region))

;; Browse Kill Ring (requires spartan-kill-ring layer)

(with-eval-after-load 'browse-kill-ring
  (defalias 'kr 'browse-kill-ring)
  (global-set-key (kbd "M-y") 'browse-kill-ring))

;; Global font size adjustments (requires spartan-theme layer)

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
(global-set-key (kbd "C-c pf") 'find-name-dired)

;; GREP FILES

(defalias 'rg 'rgrep)
(global-set-key (kbd "C-c psg") 'rgrep)

;; DIFF

(defalias 'ed 'ediff)
(global-set-key (kbd "C-c |") 'ediff)

;; GIT (requires spartan-magit layer)

(with-eval-after-load 'magit
  (defalias 'git 'magit)
  (global-set-key (kbd "C-c g") 'magit))

;; LINTER  (requires spartan-flymake layer)

(with-eval-after-load 'spartan-flymake
  (defalias 'lint 'flymake-show-diagnostics-buffer)
  (global-set-key (kbd "C-c f") 'flymake-show-diagnostics-buffer))

;; Pastebin (requires spartan-webpaste layer)

(with-eval-after-load 'spartan-webpaste
  (defalias 'pb 'webpaste-paste-buffer-or-region)
  (global-set-key (kbd "C-c C-p C-p") 'webpaste-paste-buffer-or-region))

;; DUMB TERM (requires spartan-shell layer)

(with-eval-after-load 'spartan-shell
  (defalias 'sh 'better-shell-for-current-dir)
  (global-set-key (kbd "C-c $") 'better-shell-for-current-dir))

;; COMPILE COMMAND

(setq compile-command "make -k ")
(global-set-key (kbd "<f5>") 'compile)

;; EXECUTE SCRIPT (requires spartan-shell layer)

(with-eval-after-load 'spartan-shell
  (global-set-key (kbd "<f6>") 'spartan-script-execute))

(provide 'spartan-binds-global)
