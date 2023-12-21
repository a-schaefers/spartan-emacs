;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; paredit makes (((((()))))) manageable
(use-package paredit ;; everywhere
  :straight t
  :defer t
  :init
  ;; emacs lisp
  (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
  (add-hook 'ielm-mode-hook             #'enable-paredit-mode)

  ;; lisps
  (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
  (add-hook 'lisp-mode-hook             #'enable-paredit-mode)

  ;; schemes
  (add-hook 'scheme-mode-hook           #'enable-paredit-mode)

  ;; clojure
  (with-eval-after-load 'clojure-mode
    (add-hook 'clojure-mode-hook          #'enable-paredit-mode))

  ;; racket
  (with-eval-after-load 'racket-mode
    (add-hook 'racket-mode-hook          #'enable-paredit-mode))

  ;; fennel
  (with-eval-after-load 'fennel-mode
    (add-hook 'fennel-mode-hook          #'enable-paredit-mode)))

(provide 'spartan-paredit)

;; this can be obsolete in the future, maintaining for now, update your layer name in spartan.el
;; spartan-elisp -> spartan-paredit
(provide 'spartan-elisp)
