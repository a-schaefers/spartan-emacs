;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; paredit makes (((((()))))) manageable
(use-package paredit ;; everywhere
  :straight t
  :defer t
  :init
  ;; emacs lisp
  (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
  (add-hook 'emacs-lisp-ts-mode-hook       #'enable-paredit-mode) ; for the future
  (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
  (add-hook 'ielm-mode-hook             #'enable-paredit-mode)

  ;; lisps
  (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
  (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-ts-mode-hook          #'enable-paredit-mode) ; for the future

  ;; schemes
  (add-hook 'scheme-mode-hook           #'enable-paredit-mode)
  (add-hook 'scheme-ts-mode-hook           #'enable-paredit-mode) ; for the future

  ;; clojure
  (with-eval-after-load 'clojure-mode
    (add-hook 'clojure-mode-hook          #'enable-paredit-mode)
    (add-hook 'clojure-ts-mode-hook          #'enable-paredit-mode) ; for the future
    )

  ;; racket
  (with-eval-after-load 'racket-mode
    (add-hook 'racket-mode-hook          #'enable-paredit-mode)
    (add-hook 'racket-ts-mode-hook       #'enable-paredit-mode) ; for the future
    ))

(provide 'spartan-paredit)

;; this can be obsolete in the future, maintaining for now, update your layer name in spartan.el
;; spartan-elisp -> spartan-paredit
(provide 'spartan-elisp)
