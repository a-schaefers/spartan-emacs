;;; -*- lexical-binding: t; -*-

(add-hook 'python-mode-hook 'eglot-ensure)

(with-eval-after-load 'python
  (define-key python-mode-map (kbd "M-m rr") 'python-shell-send-region)
  (define-key python-mode-map (kbd "M-m rb") 'python-shell-send-buffer)
  (define-key python-mode-map (kbd "M-m rR") 'run-python)
  (define-key python-mode-map (kbd "M-m db") 'pdb))

(provide 'spartan-python)
