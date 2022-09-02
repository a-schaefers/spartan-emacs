;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; expects 'python-language-server'


(defun spartan-python-hook ()
  (interactive)
  (setq-local tab-width 4))

(add-hook 'python-mode-hook 'spartan-python-hook)


(when (executable-find "pyls")
  (require 'eglot)
  (add-hook 'python-mode-hook 'eglot-ensure))

(with-eval-after-load 'python
  (define-key python-mode-map (kbd "M-m rr") 'python-shell-send-region)
  (define-key python-mode-map (kbd "M-m rb") 'python-shell-send-buffer)
  (define-key python-mode-map (kbd "M-m rR") 'run-python))

(provide 'spartan-python)
