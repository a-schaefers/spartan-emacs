;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; remove hostname from the GUI titlebar
(setq-default frame-title-format '("Emacs"))

;; simple mode-line

;; https://emacs.stackexchange.com/questions/5529/how-to-right-align-some-items-in-the-modeline
(defun simple-mode-line-render (left right)
  "Return a string of `window-width' length containing LEFT, and RIGHT
 aligned respectively."
  (let* ((available-width (- (window-width) (length left) 2)))
    (format (format " %%s %%%ds " available-width) left right)))

(setq mode-line-format
      '((:eval (simple-mode-line-render
                ;; left
                (format-mode-line "%* %b %l")
                ;; right
                (format-mode-line "%m")))))

;; modeline to top

(setq-default header-line-format mode-line-format)
(setq-default mode-line-format nil)

;; a glorious startup theme

(setq inhibit-startup-screen t
      initial-major-mode 'emacs-lisp-mode
      load-prefer-newer t)

  (setq initial-scratch-message "
; _______  _____  _______  ______ _______ _______
; |______ |_____] |_____| |_____/    |    |_____|
; ______| |       |     | |    \\_    |    |     |

")

;; no colors
(global-font-lock-mode -1)

(or window-system
      (add-to-list 'default-frame-alist '(tty-color-mode . -1)))

(provide 'spartan-theme)
