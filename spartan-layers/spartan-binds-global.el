;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(global-set-key (kbd "C-c i") #'(lambda ()
                                  (interactive)
                                  (find-file user-init-file)))

;; TAB is indent or auto completion
(setq tab-always-indent 'complete)

;; COLLECTION OF REDICULOUSLY USEFUL EXTENSIONS

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
  (defalias 'pro 'projectile-commander))

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
(defalias 'cc 'compile)

;; UNBIND ANNOYANCES
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))

(provide 'spartan-binds-global)
