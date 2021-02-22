;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(defun spartan-flymake-hook ()
  (require 'flymake)
  (remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)
  (add-hook 'prog-mode-hook 'flymake-mode))

(add-hook 'after-init-hook 'spartan-flymake-hook)

(provide 'spartan-flymake)
