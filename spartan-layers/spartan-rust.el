;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; expects: rust-analyzer
;; usage: https://github.com/rust-lang/rust-mode

(use-package rust-mode
  :straight t
  :demand t
  :config
  (when (executable-find "rust-analyzer")
        (with-eval-after-load 'eglot
          (add-hook 'rust-mode-hook 'eglot-ensure))))

(provide 'spartan-rust)
