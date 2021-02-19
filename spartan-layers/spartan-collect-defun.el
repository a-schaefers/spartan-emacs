;;; -*- lexical-binding: t; -*-

(defun region-to-termbin (start end)
  "push the marked region to termbin.com via shell command"
  (interactive "r")
  ;; TODO improve me
  (message "pushing region to termbin.com...")
  (shell-command-on-region start end "nc termbin.com 9999"))

(defun buffer-to-termbin ()
  "push the whole buffer to termbin.com via shell command"
  (interactive)
  ;; TODO improve me
  (message "pushing buffer to termbin.com...")
  (shell-command-on-region (point-min) (point-max) "nc termbin.com 9999"))

(defun spartan-font-resizer (x)
  (when (> x 0)
    (progn
      (setq spartan-font-size (+ 1 spartan-font-size))
      (set-face-attribute 'default nil
                          :font (concat spartan-font "-" (number-to-string spartan-font-size)))))
  (when (< x 0)
    (progn
      (setq spartan-font-size (+ -1 spartan-font-size))
      (set-face-attribute 'default nil
                          :font (concat spartan-font "-" (number-to-string spartan-font-size)))))
  (when (eq x 0)
    (progn
      (set-face-attribute 'default nil
                          :font (concat spartan-font "-" (number-to-string spartan-font-size)))))
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
