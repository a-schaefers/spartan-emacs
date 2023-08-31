;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; lsp requires clangd

;; For debugging checkout M-x gdb

;; Thx https://github.com/bbatsov/prelude
(defun spartan-c-mode-common-defaults ()
  ;; https://www.kernel.org/doc/html/v4.10/process/coding-style.html#linux-kernel-coding-style
  (setq c-default-style "linux"
        c-basic-offset 8)
  (c-set-offset 'substatement-open 0))

(setq spartan-c-mode-common-hook 'spartan-c-mode-common-defaults)

(defun spartan-makefile-mode-defaults ()
  (whitespace-toggle-options '(tabs))
  (setq indent-tabs-mode t ))

(setq spartan-makefile-mode-hook 'spartan-makefile-mode-defaults)

(add-hook 'makefile-mode-hook (lambda ()
                                (run-hooks 'spartan-makefile-mode-hook)))

;; this will affect all modes derived from cc-mode, like
;; java-mode, php-mode, etc
(add-hook 'c-mode-common-hook (lambda ()
                                (run-hooks 'spartan-c-mode-common-hook)))

(when (executable-find "clangd")
  (with-eval-after-load 'eglot
    (add-hook 'c-mode-hook 'eglot-ensure)
    (add-hook 'c++-mode-hook 'eglot-ensure)))

(provide 'spartan-c)
