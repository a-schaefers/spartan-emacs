;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; expects: rust-analyzer
;; usage: https://github.com/rust-lang/rust-mode

(add-to-list 'spartan-package-list 'rust-mode)

(when (executable-find "rust-analyzer")
        (with-eval-after-load 'eglot
          (add-hook 'rust-mode-hook 'eglot-ensure)))

(provide 'spartan-rust)
