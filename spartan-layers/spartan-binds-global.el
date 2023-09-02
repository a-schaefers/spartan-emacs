;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; UNBIND ANNOYANCES

(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))

;; TAB AUTO COMPLETION
(setq tab-always-indent 'complete)

;; BETTER-DEFAULTS

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

;; DIFF / M-x ediff has this covered

;; PROJECT MGMT / Find / Grep

(with-eval-after-load 'projectile
    (defalias 'pp 'projectile-commander)
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
