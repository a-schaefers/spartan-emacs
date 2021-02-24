;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(global-font-lock-mode -1)

(and window-system
     (progn
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
	 (set-face-background f "gray97"))))

(or window-system
    (add-to-list 'default-frame-alist '(tty-color-mode . -1)))
