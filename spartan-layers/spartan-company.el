;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; http://company-mode.github.io/
;; https://github.com/joaotavora/eglot/issues/15

(use-package company-prescient
  :after (company prescient)
  :straight t
  :defer t
  :init (company-prescient-mode 1))

(use-package company
  :straight t
  :defer t
  :init
  (add-hook 'prog-mode-hook 'company-mode)
  :config
  (setq company-idle-delay 0))

(provide 'spartan-company)
