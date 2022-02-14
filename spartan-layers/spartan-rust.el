;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(add-to-list 'spartan-package-list 'rust-mode)

(when (executable-find "rust-analyzer")
        (with-eval-after-load 'eglot
          (add-hook 'rust-mode-hook 'eglot-ensure)))

(with-eval-after-load 'rust-mode
  (define-key rust-mode-map (kbd "M-m rr") 'rust-run))

(provide 'spartan-rust)
