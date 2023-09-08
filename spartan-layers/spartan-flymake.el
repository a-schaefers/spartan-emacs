;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(use-package flymake
  :straight t
  :demand t
  :config
  (remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)
  (add-hook 'prog-mode-hook 'flymake-mode)

  ;; (defun spartan-lint ()
  ;;   (interactive)
  ;;   (flymake-mode 1)
  ;;   (flymake-show-diagnostics-buffer))

  ;; (defalias 'lint 'spartan-lint)
  )

(provide 'spartan-flymake)
