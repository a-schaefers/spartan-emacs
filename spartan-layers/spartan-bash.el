;;; -*- lexical-binding: t; -*-

(setq flymake-shellcheck-use-file nil)
(add-hook 'sh-mode-hook 'flymake-shellcheck-load)

(provide 'spartan-bash)
