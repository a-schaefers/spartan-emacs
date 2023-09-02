;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; UNBIND ANNOYANCES

(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))
(global-unset-key (kbd "M-m"))

;; TAB AUTO COMPLETION
(setq tab-always-indent 'complete) ; used by eglot for auto-completion as well

;; BETTER-DEFAULTS

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-/") 'hippie-expand)

(global-set-key (kbd "C-%") 'forward-or-backward-sexp)

;; COLLECTION OF REDICULOUSLY USEFUL EXTENSIONS

(global-set-key (kbd "C-c i") #'(lambda ()
                                  (interactive)
                                  (find-file user-init-file)))

(with-eval-after-load 'crux
  (global-set-key (kbd "C-a") 'crux-move-beginning-of-line)
  (global-set-key (kbd "C-o") 'crux-smart-open-line)
  (global-set-key (kbd "C-c C-l") 'crux-duplicate-current-line-or-region)
  (global-set-key (kbd "C-c C--") 'crux-kill-whole-line)
  (global-set-key (kbd "C-c ;") 'crux-duplicate-and-comment-current-line-or-region))

;; BROWSE KILL RING

(with-eval-after-load 'browse-kill-ring
  (global-set-key (kbd "M-y") 'browse-kill-ring))

;; REGEXP SEARCH

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; DIFF / M-x ediff has this covered

;; PROJECT MGMT / Find / Grep

(with-eval-after-load 'projectile
    (defalias 'proj 'projectile-commander)
    (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

;; GIT

(with-eval-after-load 'magit
  (defalias 'git 'magit))

;; LINTER

(with-eval-after-load 'flymake
  (defun spartan-lint ()
    (interactive)
    (flymake-mode 1)
    (flymake-show-diagnostics-buffer))
  (defalias 'lint 'spartan-lint))

;; PASTEBIN

(with-eval-after-load 'webpaste
  (defalias 'paste 'webpaste-paste-buffer-or-region))

;; DUMB TERM

(with-eval-after-load 'better-shell
  (defalias 'sh 'better-shell-for-current-dir))

;; COMPILE COMMAND

(setq compile-command "make -k ")
(global-set-key (kbd "<f5>") 'compile)

;; EXECUTE SCRIPT

(with-eval-after-load 'spartan-shell
  (global-set-key (kbd "<f6>") 'spartan-script-execute))

(provide 'spartan-binds-global)
