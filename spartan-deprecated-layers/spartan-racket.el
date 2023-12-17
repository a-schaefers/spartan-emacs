;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(use-package racket-mode
  :straight t
  :defer t)

;; hmm no quick way shown to detect path of this one https://github.com/jeapostrophe/racket-langserver
;; add to spartan.el (setq spartan-racket-langserver t)
(when (bound-and-true-p spartan-racket-langserver)
  (add-hook 'racket-mode-hook 'eglot-ensure))

(provide 'spartan-racket)
