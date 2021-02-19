;;; -*- lexical-binding: t; -*-

(defun spacemacs/alternate-buffer (&optional window)
  "Switch back and forth between current and last buffer in the
current window."
  (interactive)
  (let ((current-buffer (window-buffer window))
        (buffer-predicate
         (frame-parameter (window-frame window) 'buffer-predicate)))
    ;; switch to first buffer previously shown in this window that matches
    ;; frame-parameter `buffer-predicate'
    (switch-to-buffer
     (or (cl-find-if (lambda (buffer)
                       (and (not (eq buffer current-buffer))
                            (or (null buffer-predicate)
                                (funcall buffer-predicate buffer))))
                     (mapcar #'car (window-prev-buffers window)))
         ;; `other-buffer' honors `buffer-predicate' so no need to filter
         (other-buffer current-buffer t)))))

(defun spacemacs/alternate-window ()
  "Switch back and forth between current and last window in the
current frame."
  (interactive)
  (let (;; switch to first window previously shown in this frame
        (prev-window (get-mru-window nil t t)))
    ;; Check window was not found successfully
    (unless prev-window (user-error "Last window not found."))
    (select-window prev-window)))

(defun region-to-termbin (start end)
  "push the marked region to termbin.com via shell command"
  (interactive "r")
  (message "pushing region to termbin.com...")
  (shell-command-on-region start end "nc termbin.com 9999"))

(defun buffer-to-termbin ()
  "push the whole buffer to termbin.com via shell command"
  (interactive)
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

(defun spartan-shell-mode-compile()
  (interactive)
  (save-buffer)
  (async-shell-command (buffer-file-name)))
(add-hook 'shell-mode-hook 'compilation-shell-minor-mode)

(provide 'spartan-collect-defun)
