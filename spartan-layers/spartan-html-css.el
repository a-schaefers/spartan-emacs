;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(when (executable-find "vscode-html-language-server")
    (add-hook 'html-mode-hook 'eglot-ensure)
    (add-hook 'html-ts-mode-hook 'eglot-ensure) ; for the future
    )

(when (executable-find "vscode-css-language-server")
    (add-hook 'css-mode-hook 'eglot-ensure)
    (add-hook 'css-ts-mode-hook 'eglot-ensure))

(provide 'spartan-html-css)
