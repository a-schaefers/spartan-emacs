;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(when (executable-find "shellcheck")
  (add-to-list 'spartan-package-list 'flymake-shellcheck))

(defun spartan-bash-hook ()
  (when (executable-find "shellcheck")
    (with-eval-after-load 'flymake-shellcheck
      (setq flymake-shellcheck-use-file nil)
      (add-hook 'sh-mode-hook 'flymake-shellcheck-load)))

  (when (executable-find "bash-language-server")
    (with-eval-after-load 'eglot
      (add-hook 'sh-mode-hook 'eglot-ensure)))

  (add-hook 'shell-mode-hook 'compilation-shell-minor-mode))

(add-hook 'after-init-hook 'spartan-bash-hook)

(provide 'spartan-bash)
