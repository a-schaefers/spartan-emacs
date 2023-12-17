;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(when (executable-find "vscode-html-language-server")
    (add-hook 'html-mode-hook 'eglot-ensure))

(when (executable-find "vscode-css-language-server")
    (add-hook 'css-mode-hook 'eglot-ensure))

(or (version< emacs-version "27")
    (progn
      (when (executable-find "typescript-language-server")
        (add-hook 'js-mode-hook 'eglot-ensure))

      (add-to-list 'auto-mode-alist '("\\.ts$"  . js-mode))
      (add-to-list 'auto-mode-alist '("\\.tsx$" . js-mode))
      (add-to-list 'auto-mode-alist '("\\.js$"  . js-mode))
      (add-to-list 'auto-mode-alist '("\\.jsx$" . js-mode))))

(provide 'spartan-html-css-javascript)
