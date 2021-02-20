;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(global-font-lock-mode 0)

(blink-cursor-mode 1)
(scroll-bar-mode -1)
(fringe-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

(setq spartan-font "Source Code Pro"
      spartan-font-size '11)

(with-eval-after-load 'spartan-collect-defun
  (spartan-font-resizer 0))

(provide 'spartan-theme)
