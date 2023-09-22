;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; expects: typescript-language-server
;; usage: https://www.emacswiki.org/emacs/JavaScriptMode

(progn
      (when (executable-find "typescript-language-server")
        (add-hook 'js-mode-hook 'eglot-ensure)
        (add-hook 'typescript-ts-mode-hook 'eglot-ensure)
        (add-hook 'js-ts-mode-hook 'eglot-ensure))

      (if (bound-and-true-p treesit-auto-recipe-list)
          (progn
            (add-to-list 'auto-mode-alist '("\\.ts$"  . typescript-ts-mode))
            (add-to-list 'auto-mode-alist '("\\.tsx$" . typescript-ts-mode)))
        (progn
          (add-to-list 'auto-mode-alist '("\\.ts$"  . js-mode))
          (add-to-list 'auto-mode-alist '("\\.tsx$" . js-mode)))))

(provide 'spartan-javascript)
