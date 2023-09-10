;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; `shell' is the preferred spartan-emacs shell because eshell and ansi/multi/term are all too buggy while vterm is bloat
;; `shell' is a bash process attached to a buffer, so it has all of Emacs bindings, etc. That's perfect.

;; If you really need ncurses, you're probably doing it wrong.

(setq explicit-shell-file-name spartan-preferred-shell)

;; This little extension, is just so handy, with this enabled, now anytime you switch to a new file or dired location via C-xC-f,
;; after that, you just need to hit 'M-x sh' again and you'll get shell mode switched in to the right directory,
;; without requiring you to close and reopen other shell modes.
(use-package better-shell
  :straight t
  :demand t
  :config
  (defalias 'sh 'better-shell-for-current-dir))

;; flymake addon to support shellcheck for linting
(use-package flymake-shellcheck
     :if (executable-find "shellcheck")
     :straight t
     :demand t
     :config
     (setq flymake-shellcheck-use-file nil)
     (add-hook 'sh-mode-hook 'flymake-shellcheck-load))

;; auto chmod +x scripts
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; clickable jump to line of code from error output in shell mode
(add-hook 'shell-mode-hook 'compilation-shell-minor-mode)

;; much improved perf in shell-mode buffers
;; https://stackoverflow.com/questions/26985772/fast-emacs-shell-mode
(setq comint-move-point-for-output nil
      comint-scroll-show-maximum-output nil)

(provide 'spartan-shell)
