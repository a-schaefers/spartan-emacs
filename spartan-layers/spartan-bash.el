;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; `shell' is the preferred spartan-emacs shell because eshell and ansi/multi/term are all too buggy while vterm is bloat
;; `shell' is a bash process attached to a buffer, so it has all of Emacs bindings, etc. That's perfect.

;; If you really need ncurses, you're probably doing it wrong.

(use-package shx
  :straight t
  :demand t
  :config
  (shx-global-mode 1))

(use-package better-shell
  :straight t
  :demand t
  :config
  (shx-global-mode 1)

  (defalias 'sh 'better-shell-for-current-dir))



;; bash everywhere because this is __GNU__ Emacs after all...
(setq tramp-default-remote-shell "/bin/bash"
      explicit-shell-file-name "bash")

;; sh/bash linter
(or
 ;; prefer shellcheck
 (when (executable-find "shellcheck")
   (use-package flymake-shellcheck
     :straight t
     :demand t
     :config
     (shx-global-mode 1)
     (setq flymake-shellcheck-use-file nil)
     (add-hook 'sh-mode-hook 'flymake-shellcheck-load))))

;; auto chmod +x scripts
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; clickable jump to line of code from error output in shell mode
(add-hook 'shell-mode-hook 'compilation-shell-minor-mode)

;; much improved perf in shell-mode buffers
;; https://stackoverflow.com/questions/26985772/fast-emacs-shell-mode
(setq comint-move-point-for-output nil
      comint-scroll-show-maximum-output nil)

(provide 'spartan-bash)
