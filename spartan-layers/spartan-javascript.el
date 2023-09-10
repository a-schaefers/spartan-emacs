;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; expects: typescript-language-server
;; usage: https://www.emacswiki.org/emacs/JavaScriptMode

;; Lesser versions not even worth using Emacs with javascript I won't support it
(or (version< emacs-version "27")
    (progn
      (when (executable-find "typescript-language-server")
        (add-hook 'js-mode-hook 'eglot-ensure))

      (add-to-list 'auto-mode-alist '("\\.ts$"  . js-mode))
      (add-to-list 'auto-mode-alist '("\\.tsx$" . js-mode))
      (add-to-list 'auto-mode-alist '("\\.js$"  . js-mode))
      (add-to-list 'auto-mode-alist '("\\.jsx$" . js-mode))))

(provide 'spartan-javascript)
