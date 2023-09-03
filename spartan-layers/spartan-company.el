;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; http://company-mode.github.io/
;; https://github.com/joaotavora/eglot/issues/15

(use-package company
  :straight t
  :demand t
  :config
  (setq company-idle-delay 0)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  ;; (define-key company-active-map (kbd "<tab>") 'company-complete-selection)
  (define-key company-search-map (kbd "C-n") 'company-select-next)
  (define-key company-search-map (kbd "C-p") 'company-select-previous)

  (add-hook 'prog-mode-hook 'company-mode))

(provide 'spartan-company)
