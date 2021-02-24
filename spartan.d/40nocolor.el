;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(global-font-lock-mode -1)

(dolist (f (face-list))
  (progn
    (set-face-foreground f nil)
    (set-face-background f nil)))

(dolist (f '(highlight
	     isearch
	     query-replace
	     lazy-highlight
	     region
	     secondary-selection
	     trailing-whitespace))
  (set-face-background f "gray97"))
