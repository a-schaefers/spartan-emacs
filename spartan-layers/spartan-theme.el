;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; clean look
(blink-cursor-mode -1)
(scroll-bar-mode -1)
(fringe-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

;; remove hostname from the GUI titlebar
(setq-default frame-title-format '("Emacs"))

;; simple mode-line

;; https://emacs.stackexchange.com/questions/5529/how-to-right-align-some-items-in-the-modeline
(defun simple-mode-line-render (left right)
  "Return a string of `window-width' length containing LEFT, and RIGHT
 aligned respectively."
  (let* ((available-width (- (window-width) (length left) 2)))
    (format (format " %%s %%%ds " available-width) left right)))

(progn
  (setq-default mode-line-format
                '((:eval (simple-mode-line-render
                          ;; left
                          (format-mode-line "%* %b %l")
                          ;; right
                          (format-mode-line "%m"))))))

(provide 'spartan-theme)
