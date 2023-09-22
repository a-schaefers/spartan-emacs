;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; https://github.com/immerrr/lua-mode

(use-package lua-mode
  :straight t
  :defer t
  :init
  (autoload 'lua-mode "lua-mode" "Lua editing mode." t)
  (add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
  (add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
  :config
  (when (executable-find "lua-language-server")
    (require 'eglot)
    (add-to-list 'eglot-server-programs
                 `(lua-mode . ("lua-language-server")))
    (add-hook 'lua-mode-hook 'eglot-ensure)))

(provide 'spartan-lua)
