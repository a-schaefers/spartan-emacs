;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(setq spartan-font "Roboto Mono"
      spartan-font-size '12)

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

(global-set-key (kbd "C-=") #'(lambda ()
				(interactive)
				(spartan-font-resizer 1)))
(global-set-key (kbd "C--") #'(lambda ()
				(interactive)
				(spartan-font-resizer -1)))

(spartan-font-resizer 0)
