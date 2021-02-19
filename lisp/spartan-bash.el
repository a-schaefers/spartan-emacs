;;; -*- lexical-binding: t; -*-

(setq flymake-shellcheck-use-file nil)
(add-hook 'sh-mode-hook 'flymake-shellcheck-load)

(global-set-key (kbd "C-c $") 'better-shell-for-current-dir)

(provide 'spartan-bash)
