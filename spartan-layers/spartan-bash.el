;;; -*- lexical-binding: t; -*-

(setq flymake-shellcheck-use-file nil)
(add-hook 'sh-mode-hook 'flymake-shellcheck-load)
(add-hook 'shell-mode-hook 'compilation-shell-minor-mode)

(provide 'spartan-bash)
