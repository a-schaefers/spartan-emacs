;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(add-to-list 'spartan-package-list 'paredit)
(add-to-list 'spartan-package-list 'slime)
(add-to-list 'spartan-package-list 'clojure-mode)

;; paredit everywhere
(defun spartan-lisp-hook ()
  (require 'paredit)
  (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
  (add-hook 'ielm-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
  (add-hook 'clojure-mode-hook          #'enable-paredit-mode)
  (add-hook 'scheme-mode-hook           #'enable-paredit-mode))

;; Common Lisp
(setq inferior-lisp-program "sbcl")
(add-to-list 'auto-mode-alist '("\\.sbclrc\\'" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.cl\\'" . lisp-mode))

;; Clojure
(when (or (executable-find "clojure-lsp")
          (executable-find "clojure-lsp-bin"))
        (with-eval-after-load 'eglot
          (add-hook 'clojure-mode-hook 'eglot-ensure)))

(add-hook 'after-init-hook 'spartan-lisp-hook)

(provide 'spartan-lisp)
