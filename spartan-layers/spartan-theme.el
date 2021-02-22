;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(global-font-lock-mode 0)

(blink-cursor-mode -1)
(scroll-bar-mode -1)
(fringe-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

(setq spartan-font "Source Code Pro"
      spartan-font-size '11)

(defun spartan-font-resizer (x)
  (when (> x 0)
    (setq spartan-font-size (+ 1 spartan-font-size))
      (set-face-attribute 'default nil
                          :font (concat spartan-font "-" (number-to-string spartan-font-size))))
  (when (< x 0)
    (setq spartan-font-size (+ -1 spartan-font-size))
      (set-face-attribute 'default nil
                          :font (concat spartan-font "-" (number-to-string spartan-font-size))))
  (when (eq x 0)
    (set-face-attribute 'default nil
                          :font (concat spartan-font "-" (number-to-string spartan-font-size))))
  (message (concat spartan-font "-" (number-to-string spartan-font-size))))

(spartan-font-resizer 0)

(provide 'spartan-theme)
