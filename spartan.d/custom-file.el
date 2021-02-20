;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; for M-x customize

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(when (file-exists-p custom-file)
  (load-file custom-file))
