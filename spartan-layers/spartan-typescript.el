;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; Requires Emacs 27 or higher
;; Lesser versions not even worth using Emacs with javascript I won't support it
(or (version< emacs-version "27")
    (progn
      (when (executable-find "typescript-language-server")
        (with-eval-after-load 'eglot
          (add-hook 'js-mode-hook 'eglot-ensure)))

      ;; TODO
      ;; (with-eval-after-load 'js-mode
      ;;   (define-key js-mode-map (kbd "M-m foo") 'bar))

      (add-to-list 'auto-mode-alist '("\\.ts$" . js-mode))))

(provide 'spartan-typescript)
