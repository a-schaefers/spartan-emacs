;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(add-to-list 'spartan-package-list 'paredit)
(add-to-list 'spartan-package-list 'slime)
(add-to-list 'spartan-package-list 'clojure-mode)
(add-to-list 'spartan-package-list 'inf-clojure)

(setq inferior-lisp-program "sbcl")
(add-to-list 'auto-mode-alist '("\\.sbclrc\\'" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.cl\\'" . lisp-mode))

;; paredit everywhere
(defun spartan-lisp-hook ()
  (require 'paredit)
  (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
  (add-hook 'ielm-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
  (add-hook 'clojure-mode-hook          #'enable-paredit-mode)
  (add-hook 'scheme-mode-hook           #'enable-paredit-mode)

  ;; Clojure
  (when (executable-find "clojure-lsp")
    (with-eval-after-load 'eglot
      (add-hook 'clojure-mode-hook 'eglot-ensure)))

  (with-eval-after-load 'clojure
    (define-key clojure-mode-map (kbd "M-m rr") 'inf-clojure-eval-region)
    (define-key clojure-mode-map (kbd "M-m rb") 'inf-clojure-eval-buffer)
    (define-key clojure-mode-map (kbd "M-m rR") 'inf-clojure))

  (with-eval-after-load 'eglot
      (add-to-list 'eglot-server-programs
                   `(clojure-mode . ("clojure-lsp")))))

(add-hook 'after-init-hook 'spartan-lisp-hook)

(provide 'spartan-lisp)
