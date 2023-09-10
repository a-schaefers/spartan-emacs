;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(use-package flymake
  :straight t
  :defer t
  :init
  (remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)

  (defun spartan-lint ()
    (interactive)
    (flymake-mode 1)
    (flymake-show-diagnostics-buffer))

  (defalias 'lint 'spartan-lint))

(provide 'spartan-flymake)
