;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; http://company-mode.github.io/
;; https://github.com/joaotavora/eglot/issues/15

(use-package company-prescient
  :ensure t
  :defer t
  :init (company-prescient-mode 1))

(use-package company
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook 'company-mode)
  (add-hook 'html-ts-mode-hook 'company-mode) ; apparently not a prog-mode
  :config
  (setq company-idle-delay 0))

(provide 'spartan-company)
