;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; lsp requires clangd, company wants clang (idk why.)

;; For debugging checkout M-x gdb

;; https://www.kernel.org/doc/html/v4.10/process/coding-style.html#linux-kernel-coding-style
(setq c-default-style "linux"
      c-basic-offset 8)
(add-hook 'makefile-mode-hook (lambda ()
                                (setq indent-tabs-mode t)))
(add-hook 'c-mode-hook (lambda ()
                                (setq indent-tabs-mode t)))

(add-hook 'c-ts-mode-hook (lambda ()
                                (setq indent-tabs-mode t)))

(when (executable-find "clangd")
  (add-hook 'c-mode-hook 'eglot-ensure)
  (add-hook 'c-ts-mode-hook 'eglot-ensure))

(provide 'spartan-c)
