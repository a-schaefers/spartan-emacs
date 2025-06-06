;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; `shell' is the preferred spartan-emacs shell because eshell and ansi/multi/term are all too buggy while vterm is bloat
;; `shell' is a bash process attached to a buffer, so it has all of Emacs bindings, etc. That's perfect.

;; If you really need ncurses, you're probably doing it wrong.

;; This little extension, is just so handy, with this enabled, now anytime you switch to a new file or dired location via C-xC-f,
;; after that, you just need to hit 'M-x sh' again and you'll get shell mode switched in to the right directory,
;; without requiring you to close and reopen other shell modes.
(use-package better-shell
  :straight t
  :bind (("C-<return>" . better-shell-for-current-dir))
  :defer t)

;; auto chmod +x scripts
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; clickable jump to line of code from error output in shell mode
(add-hook 'shell-mode-hook 'compilation-shell-minor-mode)
;; Always use a login shell if bash, which it should be!
(setq explicit-bash-args '("--noediting" "-i" "-l"))

;; Persist shell-mode M-r reverse search feature to a file
(defun spartan-shell-mode-hook ()
  (when (string-match ".*bash.*" (getenv "SHELL"))
    (setq comint-input-ring-file-name "~/.bash_history"))

  (when (string-match ".*zsh.*" (getenv "SHELL"))
    (setq comint-input-ring-file-name "~/.zsh_history"))

  (comint-read-input-ring t)
  (comint-write-input-ring))

(add-hook 'shell-mode-hook 'spartan-shell-mode-hook)

(provide 'spartan-shell)
