;;; -*- lexical-binding: t; no-byte-compile: t; -*-

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

(defun forward-or-backward-sexp (&optional arg)
  "Go to the matching parenthesis character if one is adjacent to point."
  (interactive "^p")
  (cond ((looking-at "\\s(") (forward-sexp arg))
        ((looking-back "\\s)" 1) (backward-sexp arg))
        ;; Now, try to succeed from inside of a bracket
        ((looking-at "\\s)") (forward-char) (backward-sexp arg))
        ((looking-back "\\s(" 1) (backward-char) (forward-sexp arg))))

(defun spartan-script-execute()
  (interactive)
  (save-buffer)
  (async-shell-command (buffer-file-name)))

(provide 'spartan-collect-defun)
