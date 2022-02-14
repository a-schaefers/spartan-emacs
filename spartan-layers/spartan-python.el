;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; expects 'python-language-server'

(when (executable-find "pyls")
  (with-eval-after-load 'eglot
    (add-hook 'python-mode-hook 'eglot-ensure)))

(with-eval-after-load 'python
  (define-key python-mode-map (kbd "M-m rr") 'python-shell-send-region)
  (define-key python-mode-map (kbd "M-m rb") 'python-shell-send-buffer)
  (define-key python-mode-map (kbd "M-m rR") 'run-python))

(provide 'spartan-python)
